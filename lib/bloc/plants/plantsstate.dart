import 'package:baider_app/data/model/plantsmodel.dart';

abstract class PlantsState {}

class PlantsInitial extends PlantsState {}

class PlantsLoading extends PlantsState {}

class PlantsLoaded extends PlantsState {
  final List<PlantsModel> plants;
  final String? selectedRegion;    // الفلتر الحالي للمنطقة
  final String? selectedSeason;    // الفلتر الحالي للموسم

  PlantsLoaded({
    required this.plants,
    this.selectedRegion,
    this.selectedSeason,
  });
}

class PlantsError extends PlantsState {
  final String message;
  PlantsError(this.message);
}