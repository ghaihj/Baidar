import 'package:baider_app/bloc/auth/signup/signupstate.dart';
import 'package:baider_app/data/datasource/remote/auth/signup.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signupcubit extends Cubit<Signupstate> {
  final SignUpData signUpData;
  Signupcubit(this.signUpData) : super(Signupinitail());

  Future<void> signup(
    String email,
    String username,
    String phone,
    String password,
  ) async {
    emit(Signuploading());
    try {
      final data = await signUpData.signup(email, password, phone, username);

      if (data['status'] == 'success') {
        emit(Signupsecuess());
      }else{
        emit(Signupfaliuar(data['message'] ?? 'error'));
      }
    } on DioException catch (e) {
      emit(Signupfaliuar(e.response?.data?['message'] ?? 'error'));
    }
  }
}
