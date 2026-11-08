import 'package:baider_app/data/datasource/remote/favourite_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baider_app/bloc/favorites/favorites_state.dart';
import 'package:baider_app/data/model/plantsmodel.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoriteData _favoriteData;
  
  List<PlantsModel> _allFavorites = [];
  String _searchQuery = '';

  FavoritesCubit(this._favoriteData) : super(FavoritesInitial());

  /// جلب كل المفضلة
  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      var data = await _favoriteData.getFavorites();
      _allFavorites = data
          .map((json) => PlantsModel.fromJson(json))
          .toList();
      _emitLoaded(); // <------------ هون ضفناها مشان الفلترة 
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  void searchFavorites(String query) { // <----------- حطيتها هون مشان ما اعمل setstate
    _searchQuery = query;
    _emitLoaded();
  }

  // دالة داخلية: تصدر القائمة المفلترة
  void _emitLoaded() {
    final filtered = _searchQuery.isEmpty
        ? _allFavorites
        : _allFavorites.where((plant) {
            final name = plant.name.toLowerCase();
            return name.contains(_searchQuery.toLowerCase());
          }).toList();
    emit(FavoritesLoaded(favorites: filtered));
  }

  // إزالة نبتة من المفضلة
  Future<void> removeFavorite(int plantId) async {
    final current = state;
    if (current is! FavoritesLoaded) return;

    _allFavorites = _allFavorites
        .where((plant) => plant.id != plantId)
        .toList();
    _emitLoaded();

    try {
      await _favoriteData.removeFavorite(plantId);
    } catch (e) {
      await loadFavorites();
    }
  }
}
