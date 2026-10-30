import 'package:baider_app/bloc/auth/checkauth/authcubit.dart';
import 'package:baider_app/bloc/auth/login/loginstate.dart';
import 'package:baider_app/data/datasource/remote/auth/login_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<Loginstate> {
  final LoginData loginData;
  final AuthCubit authCubit;
  bool isshowpasswoed = true;
  LoginCubit(this.loginData, this.authCubit) : super(Logininitial());

  Future<void> login(String email, String password) async {
    emit(Loginloading());
    try {
      final data = await loginData.login(email, password);
      await authCubit.setAuthenticated(data['token']);
      if (data['status'] == 'success') {
        emit(Loginsecuses());
      } else {
        emit(Loginfaliuer(data['message'] ?? 'error'));
      }
    } on DioException catch (e) {
      emit(Loginfaliuer(e.response?.data?['message'] ?? 'error'));
    }
  }

  showPassword() {
    isshowpasswoed = isshowpasswoed == true ? false : true;
    emit(LoginShowPassword());
  }
}
