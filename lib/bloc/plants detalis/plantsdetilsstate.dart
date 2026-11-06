import 'package:baider_app/data/model/plantsmodel.dart';

abstract class PlantDetailsState {}

class PlantDetailsInitial extends PlantDetailsState {}

class PlantDetailsLoading extends PlantDetailsState {}

class PlantDetailsLoaded extends PlantDetailsState {
  final PlantsModel plant;
  final bool isFavorite;  // ✅ حالة المفضلة

  PlantDetailsLoaded({
    required this.plant,
    required this.isFavorite,
  });

  /// نسخة جديدة بنفس النبتة بس حالة favorite مختلفة
  PlantDetailsLoaded copyWith({ // هون يعني لما المستخدم يضغط على المفضلة بتصير هيك isFavorite: true
    PlantsModel? plant,
    bool? isFavorite,
  }) {
    return PlantDetailsLoaded(
      plant: plant ?? this.plant,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class PlantDetailsError extends PlantDetailsState {
  final String message;
  PlantDetailsError(this.message);
}