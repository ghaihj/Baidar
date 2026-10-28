import 'package:baider_app/bloc/auth/resetpassword/resetpasswordstate.dart';
import 'package:baider_app/data/datasource/remote/auth/resetpassword_data.dart'
    show ResetPasswordData;
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordData resetPasswordData;
  ResetPasswordCubit(this.resetPasswordData) : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
    required String confirmation,
  }) async {
    emit(ResetPasswordLoading());
    try {
      await resetPasswordData.resetPassword(
        email,
        code,
        password,
        confirmation,
      );
      emit(ResetPasswordSuccess());
    } on DioException catch (e) {
      emit(
        ResetPasswordFailure(
          e.response?.data?['message'] ?? 'تعذر الاتصال بالخادم',
        ),
      );
    }
  }
}
