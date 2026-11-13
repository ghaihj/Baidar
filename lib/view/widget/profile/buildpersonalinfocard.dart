import 'package:baider_app/bloc/profile/profile_state.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';

/// بطاقة المعلومات الشخصية (Name, Email, Location)
Widget buildPersonalInfoCard(Locale locale, ProfileLoaded state) {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان البطاقة
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            AppTranslations.tr(locale, 'personal_info'),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primarycolor,
            ),
          ),
        ),
        // Name
        _buildEditableField(
          label: AppTranslations.tr(locale, 'name'),
          controller: _nameController,
        ),
        const Divider(),
        // Email
        _buildEditableField(
          label: AppTranslations.tr(locale, 'email'),
          controller: _emailController,
        ),
        const Divider(),
        // Location
        _buildEditableField(
          label: AppTranslations.tr(locale, 'location'),
          controller: _locationController,
        ),
        const SizedBox(height: 16),
      ],
    ),
  );
}

/// حقل قابل للتعديل
Widget _buildEditableField({
  required String label,
  required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: AppColors.gray1),
              ),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
