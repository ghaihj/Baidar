import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';

class ResetPasswordData {
  final Dio dio;
  ResetPasswordData(this.dio);

  Future<Map<String, dynamic>> resetPassword(
    String email,
    String code,
    String password,
    String confirmation,
  ) async {
    final response = await dio.post(
      Applink.resetpassword,
      data: {
        "email": email,
        "code": code,
        "password": password,
        "password_confirmation": confirmation,
      },
    );
    return response.data;
  }
}
