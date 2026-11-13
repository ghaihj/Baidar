import 'package:baider_app/bloc/profile/profile_cubit.dart';
import 'package:baider_app/bloc/profile/profile_state.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:baider_app/view/widget/profile/buildlogoutbuttom.dart';
import 'package:baider_app/view/widget/profile/buildpersonalinfocard.dart';
import 'package:baider_app/view/widget/profile/buildprofilecard.dart';
import 'package:baider_app/view/widget/profile/buildsavebuttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  // Controllers للحقول
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  // متغيرات إظهار/إخفاء الباسورد
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().loadProfile();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              AppTranslations.tr(locale, 'profile'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primarycolor,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading || state is ProfileInitial) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primarycolor,
                    ),
                  );
                }
                if (state is ProfileError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: 8),
                        Text(state.message),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ProfileCubit>().loadProfile();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                if (state is ProfileLoaded) {
                  // ✅ ملء الـ controllers بالبيانات (مرة وحدة)
                  if (_nameController.text.isEmpty) {
                    _nameController.text = state.profile.name;
                    _emailController.text = state.profile.email;
                    _locationController.text = state.profile.location;
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProfileCubit>().loadProfile();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // === بطاقة الملف الشخصي ===
                          buildProfileCard(locale, state),
                          const SizedBox(height: 20),

                          // === بطاقة المعلومات الشخصية ===
                          buildPersonalInfoCard(locale, state),
                          const SizedBox(height: 20),

                          // === عنوان "Edit your password" ===
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              AppTranslations.tr(locale, 'edit_password'),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.gray1,
                              ),
                            ),
                          ),

                          // === بطاقة تغيير كلمة المرور ===
                          _buildPasswordCard(locale),
                          const SizedBox(height: 24),

                          // === زر Save changes ===
                          BuildSaveButton(
                            locale: locale,
                            isUpdating: state.isUpdating,
                            onPressed: () async {
                              bool success = await context
                                  .read<ProfileCubit>()
                                  .updateProfile(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    location: _locationController.text,
                                  );

                              if (_currentPasswordController.text.isNotEmpty &&
                                  _newPasswordController.text.isNotEmpty) {
                                await context
                                    .read<ProfileCubit>()
                                    .changePassword(
                                      currentPassword:
                                          _currentPasswordController.text,
                                      newPassword: _newPasswordController.text,
                                    );
                              }

                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    success
                                        ? AppTranslations.tr(
                                            locale,
                                            'save_success',
                                          )
                                        : AppTranslations.tr(
                                            locale,
                                            'save_error',
                                          ),
                                  ),
                                  backgroundColor: success
                                      ? AppColors.primarycolor
                                      : Colors.red,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),

                          // === زر Log Out ===
                          Buildlogoutbuttom(locale: locale),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }

  /// بطاقة تغيير كلمة المرور
  Widget _buildPasswordCard(Locale locale) {
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
        children: [
          // Current password
          _buildPasswordField(
            label: AppTranslations.tr(locale, 'current_password'),
            controller: _currentPasswordController,
            isVisible: _showCurrentPassword,
            onToggleVisibility: () {
              setState(() {
                _showCurrentPassword = !_showCurrentPassword;
              });
            },
          ),
          const Divider(),
          // New password
          _buildPasswordField(
            label: AppTranslations.tr(locale, 'new_password'),
            controller: _newPasswordController,
            isVisible: _showNewPassword,
            onToggleVisibility: () {
              setState(() {
                _showNewPassword = !_showNewPassword;
              });
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// حقل كلمة المرور (مع زر إظهار/إخفاء)
  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.gray1)),
          TextField(
            controller: controller,
            obscureText: !isVisible,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.primarycolor,
                  size: 20,
                ),
                onPressed: onToggleVisibility,
              ),
            ),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
