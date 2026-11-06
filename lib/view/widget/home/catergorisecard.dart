import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/data/model/categoresmodel.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel categoryModel;
  final Locale locale;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.categoryModel,
    required this.locale,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAr = locale.languageCode == 'ar';
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // ✅ استعمل Image.network مع fallback
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                  categoryModel.imageUrl,
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
              // تدرج لوني للأسفل
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              // اسم الفئة
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Text(
                  categoryModel.getLocalizedName(locale),
                  textAlign: isAr ? TextAlign.right : TextAlign.left,
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
      ),
    );
  }
}