import 'package:baider_app/bloc/plants%20detalis/plant_details_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/data/datasource/remote/favourite_data.dart';
import 'package:baider_app/data/model/plantsmodel.dart';
import 'package:baider_app/di/injection.dart';
import 'package:baider_app/view/widget/plant_details/plant_details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantCard extends StatelessWidget {
  final PlantsModel plant;
  final Locale locale;
  final VoidCallback onTap;

  const PlantCard({
    required this.plant,
    required this.locale,
    required this.onTap,
  });

  // دالة لفتح الـ Bottom Sheet
  void _showDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ← مهم عشان الـ sheet ياخد ارتفاع كبير
      backgroundColor: Colors.transparent, // ← عشان ما يكون فيه خلفية افتراضية
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetails(context), // ← استدعاء الدالة
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                plant.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.primarycolor,
                    child: const Center(
                      child: Icon(Icons.grass, color: Colors.white, size: 40),
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Text(
                plant.getLocalizedName(locale),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
