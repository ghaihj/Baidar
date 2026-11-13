import 'package:baider_app/bloc/profile/profile_state.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

/// بطاقة الملف الشخصي (Avatar + Name + Email)
  Widget buildProfileCard(Locale locale, ProfileLoaded state) {
    final firstLetter = state.profile.name.isNotEmpty
        ? state.profile.name[0].toUpperCase()
        : '?';

    return Container(
      padding: const EdgeInsets.all(20),
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
        children: [
          // Avatar - دائرة خضراء فيها الحرف الأول من الاسم
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primarycolor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                firstLetter,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primarycolor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // الاسم
          Text(
            state.profile.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // الإيميل
          Text(
            state.profile.email,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.gray1,
            ),
          ),
        ],
      ),
    );
  }