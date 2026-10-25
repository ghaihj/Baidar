import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';


class ForgetPasswordData {
  final Dio dio;
  ForgetPasswordData(this.dio);

  Future<Map<String, dynamic>> sendEmail(String email) async {
    final response = await dio.post(
      Applink.forgetpassword,
      data: {"email": email},
    );
    return response.data;
  }
}