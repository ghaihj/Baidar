import 'package:baider_app/bloc/auth/checkauth/authcubit.dart';
import 'package:baider_app/bloc/auth/checkauth/authstate.dart';
import 'package:baider_app/bloc/auth/forgetpassword/forgetpasswordcubit.dart';
import 'package:baider_app/bloc/auth/login/logincubit.dart';
import 'package:baider_app/bloc/auth/resetpassword/resetpasswordcubit.dart';
import 'package:baider_app/bloc/auth/signup/signupcubit.dart';
import 'package:baider_app/bloc/auth/verifiycubit/verifiycubit.dart';
import 'package:baider_app/bloc/home/homecubit.dart';
import 'package:baider_app/bloc/plants/plantscubit.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/core/function/go_router_refresh_stream.dart';
import 'package:baider_app/data/datasource/remote/auth/resetpassword_data.dart';
import 'package:baider_app/data/model/categoresmodel.dart';
import 'package:baider_app/di/injection.dart';
import 'package:baider_app/view/screen/auth/forgetpassword.dart';
import 'package:baider_app/view/screen/auth/loginpage.dart';
import 'package:baider_app/view/screen/auth/resertpasswordpage.dart';
import 'package:baider_app/view/screen/auth/signuppage.dart';
import 'package:baider_app/view/screen/auth/verificode.dart';
import 'package:baider_app/view/screen/favouretpage.dart';
import 'package:baider_app/view/screen/homepage.dart';
import 'package:baider_app/view/screen/main_layout.dart';
import 'package:baider_app/view/screen/onbordeing/chooselanguage.dart';
import 'package:baider_app/view/screen/onbordeing/onboardingpage.dart';
import 'package:baider_app/view/screen/onbordeing/onbordingthree.dart';
import 'package:baider_app/view/screen/onbordeing/onbordingtwopage.dart';
import 'package:baider_app/view/screen/plantspage.dart';
import 'package:baider_app/view/screen/profilepage.dart';
import 'package:baider_app/view/widget/plant_details/plant_details_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.test,
  refreshListenable: GoRouterRefreshStream(getIt<AuthCubit>().stream),
  redirect: (context, state) {
    final authState = getIt<AuthCubit>().state;
    final seenIntro =
        getIt<SharedPreferences>().getBool('onboarding_seen') ?? false;
    final loc = state.matchedLocation;

    const introPages = [
      AppRoute.onbording,
      AppRoute.onbordingtwo,
      AppRoute.onbordingthree,
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
    // =========== on bordein ==============
    GoRoute(
      path: AppRoute.onbording,
      builder: (context, state) => Onboardingpage(),
    ),
    GoRoute(
      path: AppRoute.onbordingtwo,
      builder: (context, state) => Onbordingtwopage(),
    ),
    GoRoute(
      path: AppRoute.onbordingthree,
      builder: (context, state) => Onbordingthree(),
    ),
    GoRoute(
      path: AppRoute.chooselanguage,
      builder: (context, state) => Chooselanguage(),
    ),
    // ================ auth ============
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
    // =============== home =================
    GoRoute(
      path: AppRoute.profilepage,
      builder: (context, state) => MainLayout(child: Profilepage()),
    ),
    // GoRoute(
    //   path: AppRoute.test,
    //   builder: (context, state) => Test(),  <------------ هي للتجريب
    // ),
    GoRoute(
      path: AppRoute.show,
      builder: (context, state) => PlantDetailsSheet(),
    ),

    GoRoute(
      path: AppRoute.favouretpage,
      builder: (context, state) => MainLayout(child: Favouretpage()),
    ),
    GoRoute(
      path: AppRoute.plants,
      builder: (context, state) {
        // ✅ نستلم CategoryModel من extra
        final category = state.extra as CategoryModel;

        return BlocProvider(
          create: (_) => getIt<PlantsCubit>(),
          child: Plantspage(
            categoryId: category.id,
            categoryName: category.name, // ← ضفت اسم الفئة
            categoryNameAr: category.nameAr, // ← واسم العربي
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoute.homepage,
      builder: (context, state) => MainLayout(
        child: BlocProvider(
          create: (_) => getIt<HomeCubit>(),
          child: const Homepage(),
        ),
      ),
    ),
  ],
);
