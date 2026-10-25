import 'package:baider_app/bloc/auth/logout/logoutstate.dart';
import 'package:baider_app/core/services/token_storage.dart';
import 'package:baider_app/data/datasource/remote/auth/logout_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutData logoutData;
  final TokenStorage tokenStorage;
  LogoutCubit(this.logoutData, this.tokenStorage) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await logoutData.logout();
    } on DioException {
      // نتجاهل الخطأ: حتى لو ما في إنترنت لازم يقدر المستخدم يطلع
    } finally {
      await tokenStorage.clear();
      emit(LogoutSuccess());
    }
  }
}