<?php

namespace App\Http\Controllers;

use App\Mail\ResetPasswordCodeMail;
use App\Models\PasswordResetCode;
use Dedoc\Scramble\Attributes\Endpoint;
use Dedoc\Scramble\Attributes\Group;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;

#[Group(
    name: 'Password Reset',
    description: 'Recover account access by requesting, verifying, and using an email reset code.',
)]
class PasswordResetController extends Controller
{
    private const CODE_EXPIRY_MINUTES = 15;

    #[Endpoint(
        title: 'Request a password reset code',
        description: 'Send a four-digit password reset code to the email address associated with the account. The code expires after 15 minutes.',
    )]
    public function forgotPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
        ]);

        $user = \App\Models\User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['message' => 'الإيميل غير موجود'], 404);
        }

        PasswordResetCode::where('email', $request->email)->delete();

        $code = str_pad((string) random_int(0, 9999), 4, '0', STR_PAD_LEFT);

        PasswordResetCode::create([
            'email' => $request->email,
            'code' => $code,
            'expires_at' => now()->addMinutes(self::CODE_EXPIRY_MINUTES),
        ]);

        Mail::to($request->email)->send(new ResetPasswordCodeMail($code));

        return response()->json(['message' => 'تم إرسال رمز التحقق إلى بريدك الإلكتروني', 'status' => "success"], 200);
    }

    #[Endpoint(
        title: 'Verify a password reset code',
        description: 'Check whether the four-digit reset code for the supplied email address is valid and has not expired.',
    )]
    public function verifyResetCode(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
            'code' => 'required|string|size:4',
        ]);

        $resetCode = PasswordResetCode::where('email', $request->email)
            ->where('code', $request->code)
            ->first();

        if (!$resetCode) {
            return response()->json(['message' => 'رمز التحقق غير صحيح'], 400);
        }

        if (now()->greaterThan($resetCode->expires_at)) {
            $resetCode->delete();
            return response()->json(['message' => 'الرمز غير صحيح أو منتهي'], 422);
        }

        return response()->json(['message' => 'الرمز صحيح، يمكنك الآن إعادة تعيين كلمة المرور', 'status' => "success"], 200);
    }

    #[Endpoint(
        title: 'Reset a password',
        description: 'Set a new password by providing the account email, a valid reset code, and matching password and password confirmation values.',
    )]
    public function resetPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
            'code' => 'required|string|size:4',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $resetCode = PasswordResetCode::where('email', $request->email)
            ->where('code', $request->code)
            ->first();

        if (!$resetCode) {
            return response()->json(['message' => 'رمز التحقق غير صحيح'], 400);
        }

        if (now()->greaterThan($resetCode->expires_at)) {
            $resetCode->delete();
            return response()->json(['message' => 'الرمز غير صحيح أو منتهي'], 422);
        }

        $user = \App\Models\User::where('email', $request->email)->first();

        $user->update([
            'password' => Hash::make($request->password),
        ]);

        $resetCode->delete();

        return response()->json([
            'message' => 'تم إعادة تعيين كلمة المرور بنجاح',
            'status' => "success"
        ], 200);
    }
}
