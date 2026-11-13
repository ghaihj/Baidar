import 'package:baider_app/bloc/profile/profile_cubit.dart';
import 'package:baider_app/bloc/profile/profile_state.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:baider_app/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.7,  // ✅ 70% من الشاشة
      child: BlocProvider(
        create: (_) => getIt<ProfileCubit>()..loadProfile(),
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return Column(
                  children: [
                    // === Header (Avatar + Name) ===
                    _buildHeader(context, locale, state),
                    const Divider(height: 1, color: Colors.grey),

                    // === القائمة ===
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildMenuItem(
                            context: context,
                            locale: locale,
                            icon: Icons.settings,
                            label: AppTranslations.tr(locale, 'setting'),
                            onTap: () {
                              Navigator.pop(context);  // ✅ أقفل الـ drawer
                              context.push(AppRoute.profilepage);  // ✅ روح لـ profile
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// Header: Avatar + اسم المستخدم
  Widget _buildHeader(
    BuildContext context,
    Locale locale,
    ProfileState state,
  ) {
    String name = '';
    if (state is ProfileLoaded) {
      name = state.profile.name;
    }
    final firstLetter = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // ✅ Avatar - دائرة خضراء فيها الحرف الأول
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primarycolor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  firstLetter,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primarycolor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // ✅ الاسم
            Expanded(
              child: state is ProfileLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: AppColors.primarycolor,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      name.isEmpty ? '...' : name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primarycolor,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// عنصر القائمة
  Widget _buildMenuItem({
    required BuildContext context,
    required Locale locale,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primarycolor, size: 24),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primarycolor,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}