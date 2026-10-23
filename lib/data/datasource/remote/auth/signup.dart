import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';

class SignUpData {
  final Dio dio;
  SignUpData(this.dio);

  Future<Map<String, dynamic>> signup(
    String email,
    String password,
    String phone,
    String username,
  ) async {
    var respones = await dio.post(
      Applink.signup,
      data: {
        "user_email": email,
        "user_password": password,
        "user_name": username,
        "user_phone": phone,
      },
    );
    return respones.data;
  }
}
