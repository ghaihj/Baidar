import 'package:baider_app/bloc/favorites/favorites_cubit.dart';
import 'package:baider_app/bloc/favorites/favorites_state.dart';
import 'package:baider_app/bloc/plants%20detalis/plant_details_cubit.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:baider_app/data/datasource/remote/favourite_data.dart';
import 'package:baider_app/di/injection.dart';
import 'package:baider_app/view/widget/plant_details/plant_details_sheet.dart';
import 'package:baider_app/view/widget/plants/coustomplantcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favouretpage extends StatefulWidget {
  const Favouretpage({Key? key}) : super(key: key);

  @override
  State<Favouretpage> createState() => _FavouretpageState();
}

class _FavouretpageState extends State<Favouretpage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesCubit>().loadFavorites();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return SafeArea(
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              return Column(
                children: [
                  // === العنوان ===
                  _buildTitle(locale),
                  // === البحث ===
                  _buildSearch(locale),
                  // === قائمة المفضلة ===
                  Expanded(child: _buildFavoritesList(state, locale)),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTitle(Locale locale) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        AppTranslations.tr(locale, 'favorite_plants'),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primarycolor,
        ),
      ),
    );
  }

  Widget _buildSearch(Locale locale) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: AppTranslations.tr(locale, 'search_favorites'),
            prefixIcon: Icon(Icons.search, color: AppColors.primarycolor),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesList(FavoritesState state, Locale locale) {
    if (state is FavoritesLoading || state is FavoritesInitial) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primarycolor),
      );
    }

    if (state is FavoritesError) {
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
                context.read<FavoritesCubit>().loadFavorites();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is FavoritesLoaded) {
      if (state.favorites.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 64, color: AppColors.gray1),
              const SizedBox(height: 16),
              Text(
                AppTranslations.tr(locale, 'no_favorites'),
                style: TextStyle(fontSize: 16, color: AppColors.gray1),
              ),
            ],
          ),
        );
      }

      // ✅ فلترة بالبحث
      final filteredFavorites = state.favorites.where((plant) {
        final name = plant.getLocalizedName(locale).toLowerCase();
        return name.contains(_searchQuery.toLowerCase());
      }).toList();

      return GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: filteredFavorites.length,
        itemBuilder: (context, index) {
          return PlantCard(
            plant: filteredFavorites[index],
            locale: locale,
            onTap: () {
              _showPlantDetails(context, filteredFavorites[index]);
            },
          );
        },
      );
    }

    return const SizedBox.shrink();
  }

  void _showPlantDetails(BuildContext context, dynamic plant) {
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
}


// CustomSearchField(
//   controller: _searchController,
//   hintText: AppTranslations.tr(locale, 'search_favorites'),
//   onChanged: (value) {
//     // ✅ logic خاص بالـ Favorites (frontend filter)  <------------- مشترك 
//     setState(() {
//       _searchQuery = value;
//     });
//   },
// )