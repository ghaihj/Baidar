import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/function/validinput.dart';
import 'package:baider_app/view/widget/auth/coustembuttomauth.dart';
import 'package:baider_app/view/widget/auth/coustemtextformauth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  TextEditingController _myemailcontroller = TextEditingController();
  TextEditingController _mypassoerdcontroller = TextEditingController();
  TextEditingController _mynamecontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _myemailcontroller = TextEditingController();
    _mynamecontroller = TextEditingController();
    _mypassoerdcontroller = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  valid: (val) => validInput("username", 3, 50, "username"),
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
                  valid: (val) => validInput("email", 10, 60, "email"),
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
                child:
                    // BlocBuilder<SignupCubit, Signupstate>(
                    //   builder: (context, state) {
                    //     final cubit = context.read<SignupCubit>(); <-------------- بظن ما بدي اياه 
                    //     return
                    CustomTextFormAuth(
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
                      valid: (val) => validInput("password", 6, 30, "password"),
                      isNumber: false,
                    ),
              ),
              const SizedBox(height: 40),
              Coustembuttomauth(onPressed: () {}, text: "Create Account"), // <------------- هون بدي blocbuilder 
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
    );
  }
}
