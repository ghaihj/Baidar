import 'package:baider_app/bloc/auth/login/logincubit.dart';
import 'package:baider_app/bloc/auth/signup/signupcubit.dart';
import 'package:baider_app/data/datasource/remote/auth/login.dart';
import 'package:baider_app/data/datasource/remote/auth/signup.dart';
import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void setupDI() {
  // 1) Dio: نسخة وحدة لكل التطبيق
  getIt.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(
      baseUrl: Applink.server,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {"Accept": "application/json"},
    )),
  );

  // 2) LoginData: بياخد Dio من المستودع تلقائياً
  getIt.registerLazySingleton<LoginData>(() => LoginData(getIt()));
  getIt.registerLazySingleton<SignUpData>(() => SignUpData(getIt()));

  // 3) LoginCubit: نسخة جديدة كل مرة
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<Signupcubit>(() => Signupcubit(getIt()));

}