import 'package:baider_app/data/model/plantsmodel.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<PlantsModel> favorites;

  FavoritesLoaded({required this.favorites});
}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}