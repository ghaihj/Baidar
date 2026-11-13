import 'package:baider_app/linkapi.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String name;
  final String nameAr;
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {  
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
      image: json['image_url'] ?? '',
    );
  }

  /// يرجع الاسم حسب اللغة
  String getLocalizedName(Locale locale) {
    return locale.languageCode == 'ar' ? nameAr : name;
  }


  String get imageUrl {
    // لو الصورة URL كامل (نادرة)
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }
    // لو الصورة فاضية
    if (image.isEmpty) {
      return '';  // رح يطلع errorBuilder
    }
    // لو relative path، ادمجه مع imagestatic
    final cleanPath = image.startsWith('/') ? image.substring(1) : image;
    return '${Applink.imagestatic}/$cleanPath';
  }
}