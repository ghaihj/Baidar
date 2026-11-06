import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Coustombuildsectiontitle extends StatelessWidget {
  const Coustombuildsectiontitle( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
       return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppTranslations.tr(locale, 'home_categories'),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primarycolor,
            ),
          ),
        );
      },
    );
  }
}
