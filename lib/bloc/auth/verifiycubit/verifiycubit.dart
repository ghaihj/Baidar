import 'package:baider_app/bloc/auth/verifiycubit/verifycodestate.dart';
import 'package:baider_app/data/datasource/remote/auth/forgetpassword_data.dart';
import 'package:baider_app/data/datasource/remote/auth/verifycode_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  final VerifyCodeData verifyCodeData;
  final ForgetPasswordData forgetPasswordData;

  VerifyCodeCubit(this.verifyCodeData, this.forgetPasswordData)
    : super(VerifyCodeInitial());

  Future<void> verifyCode(String email, String code) async {
    emit(VerifyCodeLoading());
    try {
      await verifyCodeData.verify(email, code);
      emit(VerifyCodeSuccess());
    } on DioException catch (e) {
      emit(
        VerifyCodeFailure(
          e.response?.data?['message'] ?? 'تعذر الاتصال بالخادم',
        ),
      );
    }
  }

  Future<void> resendCode(String email) async {
    try {
      await forgetPasswordData.sendEmail(email);
      emit(ResendCodeSuccess());
    } on DioException catch (e) {
      emit(
        ResendCodeFailure(
          e.response?.data?['message'] ?? 'تعذر الاتصال بالخادم',
        ),
      );
    }
  }
}
