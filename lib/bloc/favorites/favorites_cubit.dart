import 'package:baider_app/data/datasource/remote/favourite_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baider_app/bloc/favorites/favorites_state.dart';
import 'package:baider_app/data/model/plantsmodel.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoriteData _favoriteData;

  FavoritesCubit(this._favoriteData) : super(FavoritesInitial());

  /// جلب كل النباتات المفضلة
  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      var data = await _favoriteData.getFavorites();
      List<PlantsModel> favorites = data
          .map((json) => PlantsModel.fromJson(json))
          .toList();
      emit(FavoritesLoaded(favorites: favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  /// إزالة نبتة من المفضلة
  Future<void> removeFavorite(int plantId) async {
    final current = state;
    if (current is! FavoritesLoaded) return;

    final updatedFavorites = current.favorites
        .where((plant) => plant.id != plantId)
        .toList();
    emit(FavoritesLoaded(favorites: updatedFavorites));

    try {
      await _favoriteData.removeFavorite(plantId);
    } catch (e) {
      // لو فشل، أعد تحميل القائمة
      await loadFavorites();
    }
  }
}
