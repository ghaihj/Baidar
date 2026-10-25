import 'package:baider_app/data/datasource/remote/auth/forgetpassword_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgetpasswordstate.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordData forgetPasswordData;
  ForgetPasswordCubit(this.forgetPasswordData) : super(ForgetPasswordInitial());

  Future<void> sendEmail(String email) async {
    emit(ForgetPasswordLoading());
    try {
      await forgetPasswordData.sendEmail(email);
      emit(ForgetPasswordSuccess());
    } on DioException catch (e) {
      emit(ForgetPasswordFailure(
        e.response?.data?['message'] ?? 'تعذر الاتصال بالخادم',
      ));
    }
  }
}