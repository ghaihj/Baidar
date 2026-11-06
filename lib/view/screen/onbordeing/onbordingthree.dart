import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_images.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:baider_app/view/widget/auth/onboarding_feature_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Onbordingthree extends StatelessWidget {
  const Onbordingthree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // 1) خلفية متدرجة (تظهر لحد ما نضيف الصورة)
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF7DB87A), Color(0xFF2F6B2F)],
                  ),
                ),
              ),
              // 2) صورة الحقول (اختيارية: لو مش موجودة ما بيصير شي)
              Image.asset(
                AppImages.onbordingthree,
                fit: BoxFit.cover,
                color: const Color(0x663F7A3A),
                colorBlendMode: BlendMode.srcOver,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
              // 3) المحتوى
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          AppTranslations.tr(locale, 'onb2_title'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.17),
                      OnboardingFeatureCard(
                        icon: Icons.location_on,
                        iconColor: Colors.black87,
                        text: AppTranslations.tr(locale, 'onb2_feature1'),
                      ),
                      const SizedBox(height: 12),
                      OnboardingFeatureCard(
                        icon: Icons.water_drop,
                        iconColor: Colors.lightBlueAccent,
                        text: AppTranslations.tr(locale, 'onb2_feature2'),
                      ),
                      const SizedBox(height: 12),
                      OnboardingFeatureCard(
                        icon: Icons.calendar_month,
                        iconColor: Colors.black87,
                        text: AppTranslations.tr(locale, 'onb2_feature3'),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              // 4) زر skip بالزاوية
              PositionedDirectional(
                bottom: 24,
                end: 24,
                child: SafeArea(
                  child: TextButton(
                    onPressed: () => context.go(AppRoute.chooselanguage),
                    child: Text(
                      AppTranslations.tr(locale, 'skip'),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
