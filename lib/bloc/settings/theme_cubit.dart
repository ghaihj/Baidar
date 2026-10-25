import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences prefs;
  ThemeCubit(this.prefs) : super(_load(prefs));

  static ThemeMode _load(SharedPreferences prefs) {
    final saved = prefs.getString('theme');
    if (saved == 'dark') return ThemeMode.dark;
    if (saved == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }

  void setTheme(ThemeMode mode) {
    prefs.setString('theme', mode.name);
    emit(mode);
  }
}