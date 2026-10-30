import 'package:baider_app/bloc/auth/verifiycubit/verifiycubit.dart';
import 'package:baider_app/bloc/auth/verifiycubit/verifycodestate.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/view/widget/auth/coustembuttomauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class VerificodePage extends StatefulWidget {
  final String email;
  const VerificodePage({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificodePage> createState() => _VerificodeState();
}

class _VerificodeState extends State<VerificodePage> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _onConfirmPressed() {
    final code = _codeController.text.trim();
    if (code.length != 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter the 4-digit code')));
      return;
    }
    context.read<VerifyCodeCubit>().verifyCode(widget.email, code);
  }

  void _onResendPressed() {
    context.read<VerifyCodeCubit>().resendCode(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    final pinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.primarycolor,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
    return BlocListener<VerifyCodeCubit, VerifyCodeState>(
      listener: (context, state) {
        if (state is VerifyCodeFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is VerifyCodeSuccess) {
          // ✅ بعد التحقق الناجح → روح لصفحة reset password مع email و code
          context.push(
            AppRoute.resetpassword,
            extra: {'email': widget.email, 'code': _codeController.text.trim()},
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Text(
                  'Email Verification',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primarycolor,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'We\'ve sent a 4-digit verification code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray1,
                  ),
                ),
                const SizedBox(height: 60),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 4,
                    controller: _codeController,
                    defaultPinTheme: pinTheme,
                    focusedPinTheme: pinTheme.copyWith(
                      decoration: pinTheme.decoration!.copyWith(
                        border: Border.all(color: AppColors.primarycolor),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    // onCompleted: (_) => _onConfirmPressed(),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Didn\'t receive code?',
                      style: TextStyle(color: AppColors.gray1),
                    ),
                    TextButton(
                      onPressed: _onResendPressed, // <----- edit
                      child: const Text(
                        'Resend Code',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 120),
                SizedBox(
                  width: 200,
                  child: BlocBuilder<VerifyCodeCubit, VerifyCodeState>(
                    // ✅
                    builder: (context, state) {
                      return Coustembuttomauth(
                        text: 'Confirm',
                        isLoading: state is VerifyCodeLoading, // ✅
                        onPressed: _onConfirmPressed,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
