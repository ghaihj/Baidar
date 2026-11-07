import 'package:baider_app/bloc/plants%20detalis/plant_details_cubit.dart';
import 'package:baider_app/bloc/plants%20detalis/plantsdetilsstate.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantDetailsSheet extends StatelessWidget {
  const PlantDetailsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return BlocBuilder<PlantDetailsCubit, PlantDetailsState>(
          builder: (context, state) {
            if (state is PlantDetailsLoading || state is PlantDetailsInitial) {
              return _buildLoading();
            }
            if (state is PlantDetailsError) {
              return _buildError(state.message);
            }
            if (state is PlantDetailsLoaded) {
              return _buildContent(context, locale, state);
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget _buildLoading() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.primarycolor),
      ),
    );
  }

  Widget _buildError(String message) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 8),
            Text(message),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Locale locale,
    PlantDetailsLoaded state,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // === الصورة + الأزرار (ثابتة بالأعلى) ===
          _buildImageHeader(context, locale, state),

          // === المحتوى القابل للـ scroll ===
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // اسم النبتة + المنطقة
                _buildNameAndRegion(locale, state),

                const SizedBox(height: 20),

                // المعلومات
                _buildInfoRow(
                  icon: Icons.terrain,
                  label: AppTranslations.tr(locale, 'soil_type'),
                  value: state.plant.getLocalizedSoilType(locale),
                ),
                _buildInfoRow(
                  icon: Icons.science_outlined,
                  label: 'pH',
                  value: state.plant.ph,
                ),
                _buildInfoRow(
                  icon: Icons.thermostat_outlined,
                  label: AppTranslations.tr(locale, 'temperature'),
                  value: state.plant.temperature,
                ),
                _buildInfoRow(
                  icon: Icons.water_drop_outlined,
                  label: AppTranslations.tr(locale, 'humidity'),
                  value: state.plant.humidity,
                ),

                const SizedBox(height: 20),

                // ✅ قسم الماء والشمس (مفصل)
                _buildSection(
                  locale,
                  title: AppTranslations.tr(locale, 'water_sunlight'),
                  children: [
                    _buildInfoRow(
                      icon: Icons.opacity,
                      label: AppTranslations.tr(locale, 'irrigation'),
                      value: state.plant.irrigation,
                    ),
                    _buildInfoRow(
                      icon: Icons.refresh,
                      label: AppTranslations.tr(locale, 'frequency'),
                      value: state.plant.getLocalizedFrequency(locale),
                    ),
                    _buildInfoRow(
                      icon: Icons.wb_sunny_outlined,
                      label: AppTranslations.tr(locale, 'min_sunlight'),
                      value: state.plant.minSunlight,
                    ),
                    _buildInfoRow(
                      icon: Icons.wb_sunny,
                      label: AppTranslations.tr(locale, 'max_sunlight'),
                      value: state.plant.maxSunlight,
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                // ✅ قسم معلومات إضافية
                _buildSection(
                  locale,
                  title: AppTranslations.tr(locale, 'additional_info'),
                  children: [
                    _buildInfoRow(
                      icon: Icons.space_bar,
                      label: AppTranslations.tr(locale, 'plant_spacing'),
                      value: state.plant.plantSpacing,
                    ),
                    _buildInfoRow(
                      icon: Icons.grain_outlined,
                      label: AppTranslations.tr(locale, 'fertilization'),
                      value: state.plant.getLocalizedFertilization(locale),
                    ),
                    _buildInfoRow(
                      icon: Icons.bug_report_outlined,
                      label: AppTranslations.tr(locale, 'common_pests'),
                      value: state.plant.getLocalizedPests(locale),
                    ),
                  ],
                ),

                // الوصف
                if (state.plant.description.isNotEmpty ||
                    state.plant.descriptionAr.isNotEmpty)
                  _buildSection(
                    locale,
                    title: AppTranslations.tr(locale, 'description'),
                    children: [
                      Text(
                        state.plant.getLocalizedDescription(locale),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader(
    BuildContext context,
    Locale locale,
    PlantDetailsLoaded state,
  ) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          // الصورة
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              state.plant.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.primarycolor,
                  child: const Center(
                    child: Icon(Icons.grass, color: Colors.white, size: 60),
                  ),
                );
              },
            ),
          ),

          // تعتيم خفيف فوق الصورة
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.3), Colors.transparent],
              ),
            ),
          ),

          // اسم المنطقة (أعلى-يسار)
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                state.plant.getLocalizedRegion(locale),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // زر القلب (favorite) - أعلى-يمين
          Positioned(
            top: 16,
            right: 60,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  state.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: state.isFavorite ? Colors.red : Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  context.read<PlantDetailsCubit>().toggleFavorite();
                },
              ),
            ),
          ),

          Positioned(
            top: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 20),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameAndRegion(Locale locale, PlantDetailsLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.plant.getLocalizedName(locale),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primarycolor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          state.plant.getLocalizedRegion(locale),
          style: TextStyle(fontSize: 14, color: AppColors.gray1),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primarycolor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: AppColors.gray1),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
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

  Widget _buildSection(
    Locale locale, {
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primarycolor,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
