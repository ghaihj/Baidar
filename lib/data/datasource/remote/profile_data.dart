import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';

class ProfileData {
  final Dio dio;
  ProfileData(this.dio);

  Future<Map<String, dynamic>> getProfile() async {
    var response = await dio.get(Applink.profile);
    return response.data['data'];
  }

  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
    required String location,
  }) async {
    var response = await dio.put(
      Applink.profile,
      data: {
        'name': name,
        'email': email,
        'location': location,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    var response = await dio.post(
      Applink.changePassword,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    );
    return response.data;
  }
}