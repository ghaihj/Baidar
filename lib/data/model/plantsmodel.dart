import 'package:baider_app/linkapi.dart';
import 'package:flutter/material.dart';

class PlantsModel {
  final int id;
  final String name;
  final String nameAr;
  final String image;
  final String description;
  final String descriptionAr;
  final int categoryId;
  final String region; // المنطقة المناسبة
  final String season; // الموسم (winter, summer, spring, autumn)
  final String regionAr;
  final String soilType;
  final String soilTypeAr;
  final String ph;
  final String temperature;
  final String humidity;
  final String water;
  final String waterAr;
  final String sunlight;
  final String sunlightAr;
  final String irrigation; // "40 mm/week"
  final String frequency; // "Twice per week"
  final String frequencyAr;
  final String minSunlight; // "6 hours"
  final String maxSunlight; // "8 hours"
  final String plantingStartMonth; // "March"
  final String plantingEndMonth; // "April"
  final String harvestStartMonth; // "July"
  final String harvestEndMonth; // "September"
  final String plantSpacing; // "50 cm"
  final String fertilization; // "NPK 20-20-20..."
  final String fertilizationAr;
  final String commonPests; // "Late blight, Wilt..."
  final String commonPestsAr;

  const PlantsModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.image,
    required this.description,
    required this.descriptionAr,
    required this.categoryId,
    required this.region,
    required this.season,
    required this.regionAr,
    required this.soilType,
    required this.soilTypeAr,
    required this.ph,
    required this.temperature,
    required this.humidity,
    required this.water,
    required this.waterAr,
    required this.sunlight,
    required this.sunlightAr,
    required this.irrigation,
    required this.frequency,
    required this.frequencyAr,
    required this.minSunlight,
    required this.maxSunlight,
    required this.plantingStartMonth,
    required this.plantingEndMonth,
    required this.harvestStartMonth,
    required this.harvestEndMonth,
    required this.plantSpacing,
    required this.fertilization,
    required this.fertilizationAr,
    required this.commonPests,
    required this.commonPestsAr,
  });

  factory PlantsModel.fromJson(Map<String, dynamic> json) {
    return PlantsModel(
      id: json['id'] ?? 0,
      name: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
      image: json['image_url'] ?? '',
      description: json['description'] ?? '',
      descriptionAr: json['description_ar'] ?? '',
      categoryId: json['category_id'] ?? 0,
      region: json['region'] ?? '',
      season: json['season'] ?? '',
      regionAr: json['region_ar'] ?? '',
      soilType: json['soil_type_en'] ?? json['soil_type'] ?? '',
      soilTypeAr: json['soil_type_ar'] ?? '',
      ph: json['ph'] ?? '',
      temperature: json['temperature'] ?? '',
      humidity: json['humidity'] ?? '',
      water: json['water_en'] ?? json['water'] ?? '',
      waterAr: json['water_ar'] ?? '',
      sunlight: json['sunlight_en'] ?? json['sunlight'] ?? '',
      sunlightAr: json['sunlight_ar'] ?? '',
      irrigation: json['irrigation'] ?? '',
      frequency: json['frequency_en'] ?? json['frequency'] ?? '',
      frequencyAr: json['frequency_ar'] ?? '',
      minSunlight: json['min_sunlight'] ?? '',
      maxSunlight: json['max_sunlight'] ?? '',
      plantingStartMonth: json['planting_start_month'] ?? '',
      plantingEndMonth: json['planting_end_month'] ?? '',
      harvestStartMonth: json['harvest_start_month'] ?? '',
      harvestEndMonth: json['harvest_end_month'] ?? '',
      plantSpacing: json['plant_spacing'] ?? '',
      fertilization: json['fertilization_en'] ?? json['fertilization'] ?? '',
      fertilizationAr: json['fertilization_ar'] ?? '',
      commonPests: json['common_pests_en'] ?? json['common_pests'] ?? '',
      commonPestsAr: json['common_pests_ar'] ?? '',
    );
  }

  /// يرجع الاسم حسب اللغة الحالية
  String getLocalizedName(Locale locale) {
    return locale.languageCode == 'ar' ? nameAr : name;
  }

  String getLocalizedDescription(Locale locale) {
    return locale.languageCode == 'ar' ? descriptionAr : description;
  }

  String getLocalizedRegion(Locale locale) {
    return locale.languageCode == 'ar' ? regionAr : region;
  }

  String getLocalizedSoilType(Locale locale) {
    return locale.languageCode == 'ar' ? soilTypeAr : soilType;
  }

  String getLocalizedWater(Locale locale) {
    return locale.languageCode == 'ar' ? waterAr : water;
  }

  String getLocalizedSunlight(Locale locale) {
    return locale.languageCode == 'ar' ? sunlightAr : sunlight;
  }
  String getLocalizedFrequency(Locale locale) {
  return locale.languageCode == 'ar' ? frequencyAr : frequency;
}

String getLocalizedFertilization(Locale locale) {
  return locale.languageCode == 'ar' ? fertilizationAr : fertilization;
}

String getLocalizedPests(Locale locale) {
  return locale.languageCode == 'ar' ? commonPestsAr : commonPests;
}

  /// يرجع URL كامل للصورة
  String get imageUrl {
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }
    if (image.isEmpty) return '';
    final cleanPath = image.startsWith('/') ? image.substring(1) : image;
    return '${Applink.imagestaticplants}/$cleanPath';
  }
}
