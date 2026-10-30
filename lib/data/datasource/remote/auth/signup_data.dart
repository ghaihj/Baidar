import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';

class SignUpData {
  final Dio dio;
  SignUpData(this.dio);

  Future<Map<String, dynamic>> signup(
    String email,
    String username,
    String password,
  ) async {
    var respones = await dio.post(
      Applink.signup,
      data: {
        "email": email,
        "name": username,
        "password": password,
      },
    );
    return respones.data;
  }
}
