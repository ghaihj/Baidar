import 'package:baider_app/bloc/auth/resetpassword/resetpasswordcubit.dart';
import 'package:baider_app/bloc/auth/resetpassword/resetpasswordstate.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/function/validinput.dart';
import 'package:baider_app/view/widget/auth/coustembuttomauth.dart';
import 'package:baider_app/view/widget/auth/coustemtextformauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String code;

  const ResetPasswordPage({super.key, required this.email, required this.code, });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onResetPressed() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ResetPasswordCubit>().resetPassword(
      email: widget.email,
      code: widget.code,
      password: _passwordController.text,
      confirmation: _confirmController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return
    BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset successfully')),
          );
          context.go('/login');
        }
      },
      child:
    Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primarycolor,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'Create a new strong password\nfor your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray1,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                const Text(
                  'New Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primarycolor,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFormAuth(
                  isNumber: false,
                  hinttext: "Enter new password",
                  labeltext: "",
                  mycontroller: _passwordController,
                  obsecuretext: _obscurePassword,
                  iconData: _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onTapIcon: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  valid: (val) => validInput(val ?? '', 8, 30, "password"),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primarycolor,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFormAuth(
                  isNumber: false,
                  hinttext: "Re-enter new password",
                  labeltext: "",
                  mycontroller: _confirmController,
                  obsecuretext: _obscurePassword,
                  iconData: _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onTapIcon: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  valid:  (val) => validInput("password", 5, 100, "password"),
                ),
                const SizedBox(height: 70),
                Center(
                  child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: 220,
                        child: Coustembuttomauth(
                          text: 'Reset Password',
                          isLoading: state is ResetPasswordLoading,
                          onPressed:   _onResetPressed,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
