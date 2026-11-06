import 'package:baider_app/bloc/home/homestate.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/data/model/categoresmodel.dart';
import 'package:baider_app/view/widget/home/catergorisecard.dart';
import 'package:flutter/material.dart';

class HomeCategoriesSection extends StatelessWidget {
  final HomeState state;
  final Locale locale;
  final ValueChanged<CategoryModel> onCategoryTap;

  const HomeCategoriesSection({
    Key? key,
    required this.state,
    required this.locale,
    required this.onCategoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is HomeLoading) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primarycolor),
        ),
      );
    }

    if (state is HomeError) {
      final errorState = state as HomeError;  // ✅ casting مرة وحدة
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text(errorState.message),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // ممكن تعمل retry هنا
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is HomeLoaded) {
      final loadedState = state as HomeLoaded;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: loadedState.categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(  // ✅ استعمل الملف المنفصل
              categoryModel: loadedState.categories[index],
              locale: locale,
              onTap: () => onCategoryTap(loadedState.categories[index]),
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();  // لحالة HomeInitial
  }
}