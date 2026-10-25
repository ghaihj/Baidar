import 'package:baider_app/bloc/auth/login/logincubit.dart';
import 'package:baider_app/bloc/auth/signup/signupcubit.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/di/injection.dart';
import 'package:baider_app/view/screen/auth/loginpage.dart';
import 'package:baider_app/view/screen/auth/signuppage.dart';
import 'package:baider_app/view/screen/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(path: '/', builder: (context, state) => Homepage()),
    GoRoute(path: AppRoute.homepage, builder: (context, state) => Homepage()),
    GoRoute(
      path: AppRoute.loginpage,
      builder: (context, state) =>
          BlocProvider(create: (_) => getIt<LoginCubit>(), child: Loginpage()),
    ),
    GoRoute(
      path: AppRoute.signuppage,
      builder: (context, state) =>
          BlocProvider(create: (_) => getIt<SignupCubit>(), child: Signuppage()),
    ),
  ],
);
