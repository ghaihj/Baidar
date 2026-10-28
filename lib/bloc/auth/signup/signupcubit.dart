import 'package:baider_app/bloc/auth/signup/signupstate.dart';
import 'package:baider_app/core/services/token_storage.dart';
import 'package:baider_app/data/datasource/remote/auth/signup_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<Signupstate> {
  final SignUpData signUpData;
  bool isshowpasswoed = true;
  final TokenStorage tokenStorage;
  SignupCubit(this.signUpData, this.tokenStorage) : super(Signupinitail());

  Future<void> signup(String email, String username, String password) async {
    emit(Signuploading());
    try {
      final data = await signUpData.signup(email, username, password);
      await tokenStorage.save(data['token']);
      if (data['status'] == 'success') {
        emit(Signupsecuess());
      } else {
        emit(Signupfaliuar(data['message'] ?? 'error'));
      }
    } on DioException catch (e) {
      emit(Signupfaliuar(e.response?.data?['message'] ?? 'error'));
    }
  }

  showPassword() {
    isshowpasswoed = isshowpasswoed == true ? false : true;
    emit(SignupShowPassword());
  }
}
