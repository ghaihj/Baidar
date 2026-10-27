import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Coustembuttomauth extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool isLoading; // 1) الخاصية الجديدة

  const Coustembuttomauth({
    Key? key,
    this.onPressed,
    required this.text,
    this.isLoading = false, // 2) قيمة افتراضية
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed, // 3) تعطيل الضغط
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primarycolor,
              disabledBackgroundColor: AppColors.primarycolor, // يبقى لون الزر
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child:
                isLoading // 4) دائرة بدل النص
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    AppTranslations.tr(locale, text),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
