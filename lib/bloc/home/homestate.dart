// lib/bloc/home/home_state.dart
import 'package:baider_app/data/model/categoresmodel.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<CategoryModel> categories;
  HomeLoaded(this.categories);
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}