import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';

class LogoutData {
  final Dio dio;
  LogoutData(this.dio);

  Future<void> logout() async {
    await dio.post(Applink.logout);
  }
}
