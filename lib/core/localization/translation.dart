import 'package:flutter/material.dart';

class AppTranslations {
  static const Map<String, Map<String, String>> keys = {
    'ar': {
      'choose_language': ' اختر لغتك المفضلة',
      'login_in': 'تسجيل الدخول',
      'skip': 'تخطي',
      'continue': 'متابعة',
      'welcome_back' : 'اهلا بعودتك',
      'login_subtitle': 'سجّل دخولك لمتابعة إدارة أرضك',
      'email_label': 'البريد الإلكتروني',
      'email_hint': 'أدخل بريدك الإلكتروني',
      'password_label': 'كلمة المرور',
      'password_hint': 'أدخل كلمة المرور',
      'forgot_password': 'نسيت كلمة المرور؟',
      'no_account': 'ليس لديك حساب؟',
      'sign_up': 'إنشاء حساب',
    },
    'en': {
      'choose_language': 'Choose Your Preferred language',
      'login_in': 'Sign In',
      'welcome_back': 'Welcome Back',
      'skip': 'skip',
      'continue': 'Continue',
      'login_subtitle': 'Sign in to continue managing your land',
      'email_label': 'Email Address',
      'email_hint': 'Enter your email',
      'password_label': 'Password',
      'password_hint': 'Enter your password',
      'forgot_password': 'Forgot Password?',
      'no_account': 'Don\'t have an account?',
      'sign_up': 'Sign Up',
    },
  };
  // دالة مساعدة للترجمة
  static String tr(Locale locale, String key) {
    return keys[locale.languageCode]?[key] ?? key;
  }
}