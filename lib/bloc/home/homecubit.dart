import 'package:baider_app/bloc/home/homestate.dart';
import 'package:baider_app/data/datasource/remote/home_data.dart';
import 'package:baider_app/data/model/categoresmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeData _homeData;

  List<CategoryModel> _allCategories = [];
  String _searchQuery = '';

  HomeCubit(this._homeData) : super(HomeInitial());

  /// جلب كل الفئات
  Future<void> loadCategories() async {
    emit(HomeLoading());
    try {
      _allCategories = await _homeData.getCategories();
      _searchQuery = '';
      _emitLoaded();
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void searchCategories(String query) {
    _searchQuery = query;
    _emitLoaded(); 
  }

  void _emitLoaded() {
    final filtered = _searchQuery.isEmpty
        ? _allCategories
        : _allCategories.where((category) {
            final name = category.name.toLowerCase();
            return name.contains(_searchQuery.toLowerCase());
          }).toList();
    emit(HomeLoaded(filtered));
  }
}
