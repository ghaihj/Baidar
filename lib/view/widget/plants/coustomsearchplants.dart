import 'package:baider_app/bloc/plants/plantscubit.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Coustomsearchplants extends StatefulWidget {
  const Coustomsearchplants({Key? key}) : super(key: key);

  @override
  State<Coustomsearchplants> createState() => _CoustomsearchplantsState();
}

class _CoustomsearchplantsState extends State<Coustomsearchplants> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<PlantsCubit>().searchPlants(value);
              },
              decoration: InputDecoration(
                hintText: AppTranslations.tr(locale, 'home_search_hint'),
                prefixIcon: Icon(Icons.search, color: AppColors.primarycolor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
