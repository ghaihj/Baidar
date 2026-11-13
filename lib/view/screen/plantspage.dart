import 'package:baider_app/bloc/plants%20detalis/plant_details_cubit.dart';
import 'package:baider_app/bloc/plants/plantscubit.dart';
import 'package:baider_app/bloc/plants/plantsstate.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/data/datasource/remote/favourite_data.dart';
import 'package:baider_app/di/injection.dart';
import 'package:baider_app/view/widget/plant_details/plant_details_sheet.dart';
import 'package:baider_app/view/widget/plants/coustombuildfilter.dart';
import 'package:baider_app/view/widget/plants/coustomplantcard.dart';
import 'package:baider_app/view/widget/plants/coustomsearchplants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Plantspage extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final String categoryNameAr;

  const Plantspage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryNameAr,
  }) : super(key: key);

  @override
  State<Plantspage> createState() => _PlantspageState();
}

class _PlantspageState extends State<Plantspage> {
  @override
  void initState() {
    super.initState();
    print('category_id received: ${widget.categoryId}'); // for test
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlantsCubit>().loadPlants(categoryId: widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final title = locale.languageCode == 'ar'
            ? widget.categoryNameAr
            : widget.categoryName;
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            // ✅ زر الرجوع بيظهر تلقائياً لما نستعمل push
            title: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primarycolor,
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: AppColors.primarycolor),
          ),
          body: SafeArea(
            child: BlocBuilder<PlantsCubit, PlantsState>(
              builder: (context, state) {
                return Column(
                  children: [
                    // === الفلاتر ===
                    Coustombuildfilter(),
                    // === البحث ===
                    Coustomsearchplants(),
                    // === قائمة النباتات ===
                    Expanded(child: _buildPlantsList(state, locale)),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlantsList(PlantsState state, Locale locale) {
    if (state is PlantsLoading || state is PlantsInitial) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primarycolor),
      );
    }

    if (state is PlantsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 8),
            Text(state.message),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<PlantsCubit>().retry();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is PlantsLoaded) {
      if (state.plants.isEmpty) {
        return const Center(child: Text('No plants found'));
      }
      return GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: state.plants.length,
        itemBuilder: (context, index) {
          return PlantCard(
            plant: state.plants[index],
            locale: locale,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),  
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (sheetContext) => BlocProvider(
                  create: (_) => PlantDetailsCubit(
                    getIt<FavoriteData>(),
                    state.plants[index], // ← النبتة المضغوطة
                  )..loadDetails(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const PlantDetailsSheet()),
                ),
              );
            },
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
