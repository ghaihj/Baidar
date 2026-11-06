import 'package:baider_app/bloc/plants%20detalis/plantsdetilsstate.dart';
import 'package:baider_app/data/datasource/remote/favourite_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baider_app/data/model/plantsmodel.dart';

class PlantDetailsCubit extends Cubit<PlantDetailsState> {
  final FavoriteData favoriteData;
  final PlantsModel plant;

  PlantDetailsCubit(this.favoriteData, this.plant) : super(PlantDetailsInitial());

  /// فحص حالة الـ favorite وعرض البيانات
  Future<void> loadDetails() async {
    emit(PlantDetailsLoading());
    try {
      final isFavorite = await favoriteData.checkFavorite(plant.id);
      emit(PlantDetailsLoaded(plant: plant, isFavorite: isFavorite));
    } catch (e) {
      // لو فشل الفحص، نعرض الداتا بدون حالة favorite
      emit(PlantDetailsLoaded(plant: plant, isFavorite: false));
    }
  }

  /// تبديل حالة المفضلة (add/remove)
  Future<void> toggleFavorite() async {
    final current = state;
    if (current is! PlantDetailsLoaded) return;

    // ✅ Optimistic update: حدّث الـ UI فوراً (بدون انتظار API)
    emit(current.copyWith(isFavorite: !current.isFavorite));

    try {
      if (current.isFavorite) {
        // كان favorite → نحذفه
        await favoriteData.removeFavorite(plant.id);
      } else {
        // ما كان favorite → نضيفه
        await favoriteData.addFavorite(plant.id);
      }
    } catch (e) {
      // لو فشل، نرجع الحالة القديمة
      emit(current.copyWith(isFavorite: current.isFavorite));
    }
  }
}