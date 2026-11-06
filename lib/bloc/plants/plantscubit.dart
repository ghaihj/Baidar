import 'package:baider_app/bloc/plants/plantsstate.dart';
import 'package:baider_app/data/datasource/remote/plants_data.dart';
import 'package:baider_app/data/model/plantsmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantsCubit extends Cubit<PlantsState> {
  final PlantsData plantsData;

  // لحفظ الفلاتر الحالية عشان نستعملها بالـ reload
  int? _categoryId;
  String? _selectedRegion;
  String? _selectedSeason;
  String? _searchQuery;

  PlantsCubit(this.plantsData) : super(PlantsInitial());

  /// تحميل النباتات حسب الفئة + الفلاتر
  Future<void> loadPlants({
    required int categoryId,
    String? region,
    String? season,
    String? search,
  }) async {
    _categoryId = categoryId;
    _selectedRegion = region;
    _selectedSeason = season;
    _searchQuery = search;

    emit(PlantsLoading());
    try {
      // ✅ الـ Data رجع List من JSON
      var data = await plantsData.getPlants(
        categoryId: categoryId,
        region: region,
        season: season,
        search: search,
      );

      // ✅ تحويل JSON → PlantsModel
      List<PlantsModel> plants = data.map((json) => PlantsModel.fromJson(json)).toList();

      emit(
        PlantsLoaded(
          plants: plants,
          selectedRegion: region,
          selectedSeason: season,
        ),
      );
    } catch (e) {
      emit(PlantsError(e.toString()));
    }
  }

  /// تغيير فلتر المنطقة
  Future<void> changeRegion(String? region) async {
    if (_categoryId == null) return;
    await loadPlants(
      categoryId: _categoryId!,
      region: region,
      season: _selectedSeason,
      search: _searchQuery,
    );
  }

  /// تغيير فلتر الموسم
  Future<void> changeSeason(String? season) async {
    if (_categoryId == null) return;
    await loadPlants(
      categoryId: _categoryId!,
      region: _selectedRegion,
      season: season,
      search: _searchQuery,
    );
  }

  /// البحث
  Future<void> searchPlants(String query) async {
    if (_categoryId == null) return;
    await loadPlants(
      categoryId: _categoryId!,
      region: _selectedRegion,
      season: _selectedSeason,
      search: query,
    );
  }

  /// إعادة المحاولة لو صار خطأ
  Future<void> retry() async {
    if (_categoryId == null) return;
    await loadPlants(
      categoryId: _categoryId!,
      region: _selectedRegion,
      season: _selectedSeason,
      search: _searchQuery,
    );
  }
}
