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
  final int regionId;
  final String season; // الموسم (winter, summer, spring, autumn)
  final String regionAr;
  final String soilType;
  final String soilTypeAr;
  final String phmin;
  final String phmax;
  final String tempminc;
  final String tempmaxc;
  final int humiditymin;
  final int humiditymax;
  final String water;
  final String wateringfrequency;
  final String waterAr;
  final String sunlight;
  final String sunlightAr;
  final String irrigation; // "40 mm/week"
  final String frequency; // "Twice per week"
  final String frequencyAr;
  final int minSunlight; // "6 hours"
  final int maxSunlight; // "8 hours"
  final int plantingStartMonth; // "March"
  final int plantingEndMonth; // "April"
  final int harvestStartMonth; // "July"
  final int harvestEndMonth; // "September"
  final int plantSpacing; // "50 cm"
  final String fertilization; // "NPK 20-20-20..."
  final String fertilizationAr;
  final String commondiseases; // "Late blight, Wilt..."

  const PlantsModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.image,
    required this.description,
    required this.descriptionAr,
    required this.categoryId,
    required this.region,
    required this.regionId,
    required this.season,
    required this.regionAr,
    required this.soilType,
    required this.soilTypeAr,
    required this.phmin,
    required this.phmax,
    required this.tempmaxc,
    required this.tempminc,
    required this.humiditymin,
    required this.humiditymax,
    required this.water,
    required this.wateringfrequency,
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
    required this.commondiseases,
  });

  factory PlantsModel.fromJson(Map<String, dynamic> json) {
    return PlantsModel(
      id: json['id'] ?? 0,
      name: json['name_en']?.toString() ?? '',
      nameAr: json['name_ar']?.toString() ?? '',
      image: json['image_url']?.toString() ?? '',
      description: json['description_en']?.toString() ?? '',
      descriptionAr: json['description_ar']?.toString() ?? '',
      categoryId: json['category_id'] ?? 0,
      region: json['region']?.toString() ?? '',
      season: json['season']?.toString() ?? '',
      regionAr: json['region_ar']?.toString() ?? '',
      regionId: json['region_id'] ?? 0,
      soilType: (json['soil_type_en'] ?? json['soil_type'])?.toString() ?? '',
      soilTypeAr: json['soil_type_ar']?.toString() ?? '',
      phmin: json['soil_ph_min']?.toString() ?? '',
      phmax: json['soil_ph_max']?.toString() ?? '',
      tempminc: json['temp_min_c']?.toString() ?? '',
      tempmaxc: json['temp_max_c']?.toString() ?? '',
      humiditymin: json['humidity_min'] ?? 0,
      humiditymax: json['humidity_max'] ?? 0,
      water: (json['water_en'] ?? json['water_amount_mm'])?.toString() ?? '',
      waterAr: json['water_ar']?.toString() ?? '',
      wateringfrequency: json['watering_frequency']?.toString() ?? '',
      sunlight: (json['sunlight_en'] ?? json['sunlight'])?.toString() ?? '',
      sunlightAr: json['sunlight_ar']?.toString() ?? '',
      irrigation: json['irrigation']?.toString() ?? '',
      frequency: (json['frequency_en'] ?? json['frequency'])?.toString() ?? '',
      frequencyAr: json['frequency_ar']?.toString() ?? '',
      minSunlight: json['sun_hours_min'] ?? 0,
      maxSunlight: json['sun_hours_max'] ?? 0,
      plantingStartMonth: json['planting_start_month'] ?? 0,
      plantingEndMonth: json['planting_end_month'] ?? 0,
      harvestStartMonth: json['harvest_start_month'] ?? 0,
      harvestEndMonth: json['harvest_end_month'] ?? 0,
      plantSpacing: json['spacing_cm'] ?? 0,
      fertilization:
          (json['fertilization_en'] ?? json['fertilization'])?.toString() ?? '',
      fertilizationAr: json['fertilization_ar']?.toString() ?? '',
      commondiseases: json['common_diseases']?.toString() ?? '',
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
