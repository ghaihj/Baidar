import 'package:baider_app/bloc/auth/forgetpassword/forgetpasswordcubit.dart';
import 'package:baider_app/bloc/auth/forgetpassword/forgetpasswordstate.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/core/function/validinput.dart';
import 'package:baider_app/linkapi.dart';
import 'package:baider_app/view/widget/auth/coustembuttomauth.dart';
import 'package:baider_app/view/widget/auth/coustemtextformauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSendPressed() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ForgetPasswordCubit>().sendEmail(_emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is ForgetPasswordSuccess) {
          context.push(Applink.verifycode, extra: _emailController.text.trim());
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Code sent')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // زر الرجوع (السهم على اليسار)
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.pop(),
          ),
        ),
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
                      'Forgot Password',
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
                      'Enter your email address to\nreceive a password reset code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  const Text(
                    'Email Address',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primarycolor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormAuth(
                    isNumber: false,
                    hinttext: "Enter your email",
                    iconData: Icons.email,
                    mycontroller: _emailController,
                    labeltext: "",
                    valid: (val) => validInput("email", 6, 30, "email"),
                  ),
                  const SizedBox(height: 110),
                  Center(
                    child:
                        BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                          listener: (context, state) {
                            if (state is ForgetPasswordSuccess) {
                              context.push(
                                AppRoute.verifiycode,
                                extra: _emailController.text.trim(),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Coustembuttomauth(
                              text: 'Send Code',
                              isLoading: state is ForgetPasswordLoading,
                              onPressed: _onSendPressed,
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
