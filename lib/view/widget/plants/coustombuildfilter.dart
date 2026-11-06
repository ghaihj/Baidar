import 'package:baider_app/bloc/plants/plantscubit.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Coustombuildfilter extends StatefulWidget {
  const Coustombuildfilter({Key? key}) : super(key: key);

  @override
  State<Coustombuildfilter> createState() => _CoustombuildfilterState();
}

class _CoustombuildfilterState extends State<Coustombuildfilter> {
  @override
  Widget build(BuildContext context) {
    final List<String> _regions = [
      'all',
      'north',
      'south',
      'central',
      'coastal',
    ];
    final List<String> _seasons = [
      'all',
      'spring',
      'summer',
      'autumn',
      'winter',
    ];
    String? _selectedSeason;
    String? _selectedRegion;

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  value: _selectedRegion ?? 'all',
                  hint: AppTranslations.tr(locale, 'select_region'),
                  items: _regions,
                  onChanged: (value) {
                    setState(() {
                      _selectedRegion = value;
                    });
                    context.read<PlantsCubit>().changeRegion(value);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  value: _selectedSeason ?? 'all',
                  hint: AppTranslations.tr(locale, 'select_season'),
                  items: _seasons,
                  onChanged: (value) {
                    setState(() {
                      _selectedSeason = value;
                    });
                    context.read<PlantsCubit>().changeSeason(value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropdown({
    required String value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint),
          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
