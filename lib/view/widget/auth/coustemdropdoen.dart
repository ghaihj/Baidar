// ويدجت منفصلة للقائمة المنسدلة (عشان تستهلك Cubit وتعدل قيمته)
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageDropdown extends StatefulWidget {
  @override
  State<LanguageDropdown> createState() => LanguageDropdownState();
}

class LanguageDropdownState extends State<LanguageDropdown> {
  // القيم الحالية نأخدها من LocaleCubit
  String? _currentCode;

  final List<Map<String, String>> _languages = const [
    {'code': 'en', 'name': 'English'},
    {'code': 'ar', 'name': 'العربية'},
  ];

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>().state;
    _currentCode = locale.languageCode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _currentCode,
          isExpanded: true,
          items: _languages.map((lang) {
            return DropdownMenuItem<String>(
              value: lang['code'],
              child: Text(lang['name']!),
            );
          }).toList(),
          onChanged: (String? newCode) {
            if (newCode != null) {
              // استدعاء الـ Cubit لتغيير اللغة + حفظها
              context.read<LocaleCubit>().changeLanguage(newCode);
            }
          },
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Color(0xFF28422A)),
        ),
      ),
    );
  }
}