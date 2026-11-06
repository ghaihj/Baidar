import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoustombuildHeader extends StatelessWidget {
  const CoustombuildHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 48), // ← نفس حجم IconButton
              Spacer(),
              Text(
                AppTranslations.tr(locale, 'home_title'),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primarycolor,
                ),
              ),
              Spacer(),
              // زر الإشعارات (اختياري)
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: AppColors.primarycolor,
                ),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
