import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';

class VerifyCodeData {
  final Dio dio;
  VerifyCodeData(this.dio);

  Future<Map<String, dynamic>> verify(String email, String code) async {
    final response = await dio.post(
      Applink.verifycode,
      data: {"email": email, "code": code},
    );
    return response.data;
  }
}