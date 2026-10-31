<?php

namespace App\Http\Controllers;

use Dedoc\Scramble\Attributes\Endpoint;
use Dedoc\Scramble\Attributes\Group;
use Illuminate\Http\Request;

#[Group(
    name: 'Authentication',
    description: 'Create Baidar accounts and manage user sign-in sessions.',
)]
class AuthController extends Controller
{
    #[Endpoint(
        title: 'Register a new account',
        description: 'Create an account with a name, email address, and password. A Sanctum access token is returned on success.',
    )]
    public function register(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
        ]);

        $user = \App\Models\User::create([
            'name' => $validatedData['name'],
            'email' => $validatedData['email'],
            'password' => bcrypt($validatedData['password']),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json(['message' => 'User registered successfully', 'token' => $token, 'status' => "success"], 201);
    }

    #[Endpoint(
        title: 'Sign in',
        description: 'Authenticate with an email address and password to receive a Sanctum access token.',
    )]
    public function login(Request $request)
    {
        $validatedData = $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $user = \App\Models\User::where('email', $validatedData['email'])->first();

        if (!auth()->attempt($validatedData)) {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json(['message' => 'User logged in successfully', 'token' => $token, 'status' => "success"], 200);
    }

    #[Endpoint(
        title: 'Sign out',
        description: 'Revoke the current access token to end the user session.',
    )]
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'User logged out successfully', 'status' => "success"], 200);
    }
}
