import 'package:baider_app/bloc/auth/checkauth/authcubit.dart';
import 'package:baider_app/bloc/auth/forgetpassword/forgetpasswordcubit.dart';
import 'package:baider_app/bloc/auth/login/logincubit.dart';
import 'package:baider_app/bloc/auth/logout/logoutcubit.dart';
import 'package:baider_app/bloc/auth/resetpassword/resetpasswordcubit.dart';
import 'package:baider_app/bloc/auth/signup/signupcubit.dart';
import 'package:baider_app/bloc/auth/verifiycubit/verifiycubit.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/bloc/settings/theme_cubit.dart';
import 'package:baider_app/core/middleware/auth_interceptor.dart';
import 'package:baider_app/core/services/token_storage.dart';
import 'package:baider_app/data/datasource/remote/auth/forgetpassword_data.dart';
import 'package:baider_app/data/datasource/remote/auth/login_data.dart';
import 'package:baider_app/data/datasource/remote/auth/logout_data.dart';
import 'package:baider_app/data/datasource/remote/auth/resetpassword_data.dart';
import 'package:baider_app/data/datasource/remote/auth/signup_data.dart';
import 'package:baider_app/data/datasource/remote/auth/verifycode_data.dart';
import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // 1) Dio: نسخة وحدة لكل التطبيق
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(getIt()));

  // نسخة واحدة لكل تطبيق
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Applink.server,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {"Accept": "application/json"},
      ),
    );
    dio.interceptors.add(AuthInterceptor(getIt()));
    return dio;
  });

  // 2) Data: بياخد Dio من المستودع تلقائياً
  getIt.registerLazySingleton<LoginData>(() => LoginData(getIt()));
  getIt.registerLazySingleton<SignUpData>(() => SignUpData(getIt()));
  getIt.registerLazySingleton<ForgetPasswordData>(
    () => ForgetPasswordData(getIt()),
  );
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit(getIt()));
  getIt.registerLazySingleton<LocaleCubit>(() => LocaleCubit(getIt()));
  getIt.registerLazySingleton<LogoutData>(() => LogoutData(getIt()));
  getIt.registerLazySingleton<VerifyCodeData>(() => VerifyCodeData(getIt()));
  getIt.registerLazySingleton<ResetPasswordData>(() => ResetPasswordData(getIt()));
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt()));

  // 3) Cubit: نسخة جديدة كل مرة
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<LoginData>(), getIt()),
  );
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt(), getIt()));
  getIt.registerFactory<VerifyCodeCubit>(
    () => VerifyCodeCubit(getIt(), getIt()),
  );
  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(getIt<ForgetPasswordData>()),
  );
  getIt.registerFactory<LogoutCubit>(() => LogoutCubit(getIt(), getIt()));
  getIt.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getIt()));
}
