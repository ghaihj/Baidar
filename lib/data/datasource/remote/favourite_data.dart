import 'package:baider_app/linkapi.dart';
import 'package:dio/dio.dart';

class FavoriteData {
  final Dio dio;
  FavoriteData(this.dio);

  /// جلب كل النباتات المفضلة (لصفحة Favorites)
  Future<List<dynamic>> getFavorites() async {
    var response = await dio.get(Applink.favorites);
    return response.data['data'];
  }

  /// إضافة نبتة للمفضلة
  Future<Map<String, dynamic>> addFavorite(int plantId) async {
    var response = await dio.post(
      Applink.favoritesAdd,
      data: {'plant_id': plantId},
    );
    return response.data;
  }

  /// إزالة نبتة من المفضلة
  Future<Map<String, dynamic>> removeFavorite(int plantId) async {
    var response = await dio.post(
      Applink.favoritesRemove,
      data: {'plant_id': plantId},
    );
    return response.data;
  }

  /// فحص هل النبتة بالمفضلة (للزر القلب)
  Future<bool> checkFavorite(int plantId) async {
    var response = await dio.get('${Applink.favorites}/$plantId/check');
    return response.data['data']['is_favorite'] ?? false;
  }
}