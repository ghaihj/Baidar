import 'package:baider_app/bloc/plants%20detalis/plant_details_cubit.dart';
import 'package:baider_app/data/datasource/remote/favourite_data.dart';
import 'package:baider_app/data/model/plantsmodel.dart';
import 'package:baider_app/di/injection.dart';
import 'package:baider_app/view/widget/plant_details/plant_details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showPlantDetails(BuildContext context, PlantsModel plant) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => BlocProvider(
      create: (_) =>
          PlantDetailsCubit(getIt<FavoriteData>(), plant)..loadDetails(),
      child: const PlantDetailsSheet(),
    ),
  );
}
