import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';

class LoginData {
 final Dio dio;
  LoginData(this.dio);

  Future<Map<String , dynamic>> login(String email, String password) async {
    var response = await dio.post(
      Applink.login,
      data: {"email": email, "password": password},
    );
    return response.data;
  }
}
