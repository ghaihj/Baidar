import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';

class BuildSaveButton extends StatelessWidget {
  final Locale locale;
  final bool isUpdating;
  final VoidCallback onPressed;  // ← callback

  const BuildSaveButton({
    Key? key,
    required this.locale,
    required this.isUpdating,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isUpdating ? null : onPressed,  // ← نادي الـ callback
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primarycolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: isUpdating
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                AppTranslations.tr(locale, 'save_changes'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}