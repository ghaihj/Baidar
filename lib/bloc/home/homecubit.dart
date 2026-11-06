import 'package:baider_app/bloc/home/homestate.dart';
import 'package:baider_app/data/datasource/remote/home_data.dart';
import 'package:baider_app/data/model/categoresmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeData homeData;

  HomeCubit(this.homeData) : super(HomeInitial());

  Future<void> loadCategories() async {
    emit(HomeLoading());
    try {
      final categories = await homeData.getCategories();
      emit(HomeLoaded(categories));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  // ✅ ميثود البحث
  Future<void> searchCategories(String query) async {
    emit(HomeLoading());
    try {
      var data = await homeData.searchCategories(query);
      List<CategoryModel> categories = data
          .map((json) => CategoryModel.fromJson(json))
          .toList();
      emit(HomeLoaded(categories));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
