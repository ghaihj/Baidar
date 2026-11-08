import 'package:baider_app/bloc/favorites/favorites_state.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/view/widget/favorite/showplantdetails.dart';
import 'package:baider_app/view/widget/plants/coustomplantcard.dart';
import 'package:flutter/material.dart';

Widget buildFavoritesList(FavoritesState state, Locale locale) {
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
          ],
        ),
      );
    }

    if (state is FavoritesLoaded) {
      if (state.favorites.isEmpty) {
        return Center(
          child: Icon(Icons.favorite_border, size: 64, color: AppColors.gray1),
        );
      }

      return GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: state.favorites.length,
        itemBuilder: (context, index) {
          return PlantCard(
            plant: state.favorites[index],
            locale: locale,
            onTap: () {
              showPlantDetails(context, state.favorites[index]);
            },
          );
        },
      );
    }
    return const SizedBox.shrink();
  }