import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  final SharedPreferences prefs;
  LocaleCubit(this.prefs) : super(Locale(prefs.getString('lang') ?? 'en'));

  void changeLanguage(String code) {
    prefs.setString('lang', code);
    emit(Locale(code));
  }
}