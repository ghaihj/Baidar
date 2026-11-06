import 'package:baider_app/data/model/categoresmodel.dart';
import 'package:dio/dio.dart';
import 'package:baider_app/linkapi.dart';

class HomeData {
  final Dio _dio;
  HomeData(this._dio);

  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get(Applink.homepage);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    }
    throw Exception('Failed to load categories');
  }

  // ✅ ميثود البحث
  Future<List<dynamic>> searchCategories(String query) async {
    var response = await _dio.get(
      Applink.searchCategories,
      queryParameters: {'name': query}, // ← أو أي اسم parameter حدده صاحبك
    );
    return response.data['data'];
  }
}
