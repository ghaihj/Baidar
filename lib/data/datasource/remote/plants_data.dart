import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';

class PlantsData {
  final Dio dio;
  PlantsData(this.dio);

  Future<List<dynamic>> getPlants({
    required int categoryId,
    String? region,
    String? season,
    String? search,
  }) async {
    var queryParams = <String, dynamic>{};

    // ✅ ضيف الفلاتر كـ query parameters
    if (region != null && region.isNotEmpty && region != 'all') {
      queryParams['region'] = region;
    }
    if (season != null && season.isNotEmpty && season != 'all') {
      queryParams['season'] = season;
    }
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search; // ← الباك بفلتر على هاد
    }

    var response = await dio.get(
      '${Applink.homepage}/$categoryId/plants', // ← path parameter
      queryParameters: queryParams,
    );

    return response.data['data']['plants'];
  }
}
