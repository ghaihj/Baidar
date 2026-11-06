import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/constant/app_images.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBuildBanner extends StatelessWidget {
  const CustomBuildBanner({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isAr = locale.languageCode == 'ar';
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      AppImages.discoverimages,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(color: AppColors.primarycolor.withOpacity(0.55)),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: isAr 
                          ? Alignment.centerRight 
                          : Alignment.centerLeft,  // ✅ يتبع اللغة
                      child: Text(
                        AppTranslations.tr(locale, 'home_hero_title'),
                        textAlign: isAr ? TextAlign.right : TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}