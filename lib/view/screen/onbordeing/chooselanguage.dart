import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:baider_app/di/injection.dart';
import 'package:baider_app/view/widget/auth/coustemdropdoen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chooselanguage extends StatelessWidget {
  const Chooselanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 180),
              Text(
                AppTranslations.tr(locale, "choose_language"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.primarycolor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              LanguageDropdown(),
              SizedBox(height: 100),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: AppColors.primarycolor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    await getIt<SharedPreferences>().setBool(
                      'onboarding_seen',
                      true,
                    );
                    if (context.mounted) {
                      context.go(AppRoute.loginpage);
                    } // مو homepage
                  },
                  child: Text(
                    AppTranslations.tr(locale, "continue"),
                    style: TextStyle(color: Colors.white),
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
