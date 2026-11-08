import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Coustomtitle extends StatelessWidget {
  const Coustomtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
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
      },
    );
  }
}
