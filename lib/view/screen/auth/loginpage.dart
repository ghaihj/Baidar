import 'package:baider_app/bloc/auth/login/logincubit.dart';
import 'package:baider_app/bloc/auth/login/loginstate.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/core/function/validinput.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:baider_app/view/widget/auth/coustembuttomauth.dart';
import 'package:baider_app/view/widget/auth/coustemtextformauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  // Controllers - لازم نحتفظ فيهم بالـ State ونحطهم بـ dispose
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // GlobalKey للتحقق من صحة الفورم
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginCubit>().login(
      _emailController.text.trim(), // trim للإيميل
      _passwordController.text, // كلمة السر بدون trim
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, Loginstate>(
      listener: (context, state) {
        if (state is Loginfaliuer) {
          // اعرض رسالة الخطأ
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.massege), // ← حسب اسم الحقل عندك
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.grey[50],
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 60),
                        // العنوان: Welcome Back!
                        Text(
                          AppTranslations.tr(locale, 'welcome_back'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            color: AppColors.primarycolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // العنوان الفرعي
                        Text(
                          AppTranslations.tr(locale, 'login_subtitle'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.gray1,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          AppTranslations.tr(locale, 'email_label'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primarycolor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // حقل البريد الإلكتروني
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CustomTextFormAuth(
                            mycontroller: _emailController,
                            hinttext: AppTranslations.tr(locale, 'email_hint'),
                            labeltext: AppTranslations.tr(
                              locale,
                              'email_label',
                            ),
                            iconData: Icons.email_outlined,
                            valid: (val) => validInput(val!, 10, 60, "email"),
                            isNumber: false,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppTranslations.tr(locale, 'password_label'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primarycolor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // حقل كلمة المرور
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CustomTextFormAuth(
                            onTapIcon: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            mycontroller: _passwordController,
                            hinttext: AppTranslations.tr(
                              locale,
                              'password_hint',
                            ),
                            labeltext: AppTranslations.tr(
                              locale,
                              'password_label',
                            ),
                            obsecuretext: _obscurePassword,
                            iconData: _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            valid: (val) => validInput(val!, 6, 30, "password"),
                            isNumber: false,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // رابط نسيت كلمة المرور
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              context.push(AppRoute.forgetpassword);
                            },
                            child: Text(
                              AppTranslations.tr(locale, 'forgot_password'),
                              style: TextStyle(
                                color: AppColors.gray1,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // زر Sign In
                        BlocBuilder<LoginCubit, Loginstate>(
                          builder: (context, state) {
                            return Coustembuttomauth(
                              isLoading: state is Loginloading,
                              onPressed: _onLoginPressed,
                              text: "login_in",
                            );
                          },
                        ),
                        const SizedBox(height: 70),
                        // رابط "ليس لديك حساب؟ إنشاء حساب"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppTranslations.tr(locale, 'no_account'),
                              style: TextStyle(
                                color: AppColors.gray1,
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.push(AppRoute.signuppage);
                              },
                              child: Text(
                                AppTranslations.tr(locale, 'sign_up'),
                                style: TextStyle(
                                  color: AppColors.primarycolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
