import 'package:baider_app/bloc/auth/checkauth/authcubit.dart';
import 'package:baider_app/bloc/auth/checkauth/authstate.dart';
import 'package:baider_app/bloc/auth/forgetpassword/forgetpasswordcubit.dart';
import 'package:baider_app/bloc/auth/login/logincubit.dart';
import 'package:baider_app/bloc/auth/resetpassword/resetpasswordcubit.dart';
import 'package:baider_app/bloc/auth/signup/signupcubit.dart';
import 'package:baider_app/bloc/auth/verifiycubit/verifiycubit.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/core/function/go_router_refresh_stream.dart';
import 'package:baider_app/data/datasource/remote/auth/resetpassword_data.dart';
import 'package:baider_app/di/injection.dart';
import 'package:baider_app/view/screen/auth/forgetpassword.dart';
import 'package:baider_app/view/screen/auth/loginpage.dart';
import 'package:baider_app/view/screen/auth/resertpasswordpage.dart';
import 'package:baider_app/view/screen/auth/signuppage.dart';
import 'package:baider_app/view/screen/auth/verificode.dart';
import 'package:baider_app/view/screen/homepage.dart';
import 'package:baider_app/view/screen/onbordeing/chooselanguage.dart';
import 'package:baider_app/view/screen/onbordeing/onboardingpage.dart';
import 'package:baider_app/view/screen/onbordeing/onbordingtwopage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.homepage,
  refreshListenable: GoRouterRefreshStream(getIt<AuthCubit>().stream),
  redirect: (context, state) {
    final authState = getIt<AuthCubit>().state;
    final seenIntro =
        getIt<SharedPreferences>().getBool('onboarding_seen') ?? false;
    final loc = state.matchedLocation;

    const introPages = [
      AppRoute.onbording,
      AppRoute.onbordingtwo,
      AppRoute.chooselanguage,
    ];
    const authPages = [
      AppRoute.loginpage,
      AppRoute.signuppage,
      AppRoute.forgetpassword,
      AppRoute.verifiycode,
      AppRoute.resetpassword,
    ];
    final isIntroPage = introPages.contains(loc);
    final isAuthPage = authPages.contains(loc);


    // 1) مسجّل: لا صفحات بداية ولا صفحات دخول
    if (authState is Authenticated) {
      return (isIntroPage || isAuthPage) ? AppRoute.homepage : null;
    }

    // 2) جديد: صفحات البداية الثلاثة مسموحة، وغيرها يرجّعه للأولى
    if (!seenIntro) {
      return isIntroPage ? null : AppRoute.onbording;
    }

    // 3) شاف البداية ومش مسجّل: صفحات الدخول بس
    return isAuthPage ? null : AppRoute.loginpage;
  },

  routes: [
    GoRoute(path: AppRoute.homepage, builder: (context, state) => Homepage()),
    GoRoute(
      path: AppRoute.loginpage,
      builder: (context, state) =>
          BlocProvider(create: (_) => getIt<LoginCubit>(), child: Loginpage()),
    ),
    GoRoute(
      path: AppRoute.signuppage,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<SignupCubit>(),
        child: Signuppage(),
      ),
    ),
    GoRoute(
      path: AppRoute.onbording,
      builder: (context, state) => Onboardingpage(),
    ),
    GoRoute(
      path: AppRoute.onbordingtwo,
      builder: (context, state) => Onbordingtwopage(),
    ),
    GoRoute(
      path: AppRoute.chooselanguage,
      builder: (context, state) => Chooselanguage(),
    ),
    GoRoute(
      path: AppRoute.verifiycode,
      builder: (context, state) {
        final email = state.extra as String;
        return BlocProvider(
          create: (_) => getIt<VerifyCodeCubit>(),
          child: VerificodePage(email: email),
        );
      },
    ),
    GoRoute(
      path: AppRoute.forgetpassword,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<ForgetPasswordCubit>(),
        child: Forgetpassword(),
      ),
    ),
    GoRoute(
      path: AppRoute.resetpassword,
      builder: (context, state) {
        final extra = state.extra as Map<String, String>;
        return BlocProvider(
          create: (_) => ResetPasswordCubit(
            ResetPasswordData(getIt<Dio>()),
            // أو حسب شو عندك بالـ constructor
          ),
          child: ResetPasswordPage(
            email: extra['email']!,
            code: extra['code']!,
          ),
        );
      },
    ),
  ],
);
