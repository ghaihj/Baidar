import 'package:baider_app/bloc/auth/signup/signupcubit.dart';
import 'package:baider_app/bloc/auth/signup/signupstate.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/function/validinput.dart';
import 'package:baider_app/view/widget/auth/coustembuttomauth.dart';
import 'package:baider_app/view/widget/auth/coustemtextformauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final TextEditingController _myemailcontroller = TextEditingController();
  final TextEditingController _mypassoerdcontroller = TextEditingController();
  final TextEditingController _mynamecontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _myemailcontroller.dispose();
    _mynamecontroller.dispose();
    _mypassoerdcontroller.dispose();
    super.dispose();
  }

  void _onSignupPressed() {
    if (!_formKey.currentState!.validate()) return;
    context.read<SignupCubit>().signup(
      _myemailcontroller.text.trim(),
      _mynamecontroller.text.trim(),
      _mypassoerdcontroller.text, // كلمة السر بدون trim
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, Signupstate>(
      listener: (context, state) {
        if (state is Signupfaliuar) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.massegs), // ← حسب اسم الحقل بالـ state عندك
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                const SizedBox(height: 20),
                Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primarycolor,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Fill in your details to get started",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 50),
                //full name
                Text(
                  "Full Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primarycolor,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CustomTextFormAuth(
                    mycontroller: _mynamecontroller,
                    hinttext: "Enter your full name",
                    labeltext: "",
                    iconData: Icons.person_outline,
                    valid: (val) => validInput(val!, 3, 50, "username"),
                    isNumber: false,
                  ),
                ),
                const SizedBox(height: 20),
                //Email
                Text(
                  "Email Address",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primarycolor,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CustomTextFormAuth(
                    mycontroller: _myemailcontroller,
                    hinttext: "Enter your email",
                    labeltext: "",
                    iconData: Icons.email_outlined,
                    valid: (val) => validInput(val!, 10, 60, "email"),
                    isNumber: false,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primarycolor,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CustomTextFormAuth(
                    mycontroller: _mypassoerdcontroller,
                    hinttext: "Create a password",
                    labeltext: "",
                    iconData: _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    obsecuretext: _obscurePassword,
                    onTapIcon: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    valid: (val) => validInput(val!, 6, 30, "password"),
                    isNumber: false,
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<SignupCubit, Signupstate>(
                  builder: (context, state) {
                    return Coustembuttomauth(
                      isLoading: state is Signuploading,
                      onPressed: _onSignupPressed,
                      text: "Create Account",
                    );
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: AppColors.primarycolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
