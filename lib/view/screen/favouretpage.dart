import 'package:baider_app/bloc/favorites/favorites_cubit.dart';
import 'package:baider_app/bloc/favorites/favorites_state.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:baider_app/core/shared/custom_search_field.dart';
import 'package:baider_app/view/widget/favorite/coustombuildlist.dart';
import 'package:baider_app/view/widget/favorite/coustomtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favouretpage extends StatelessWidget {
  const Favouretpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return SafeArea(
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              return Column(
                children: [
                  Coustomtitle(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: CustomSearchField(
                      hintText: AppTranslations.tr(locale, 'search_favorites'),
                      onChanged: (value) {
                        context.read<FavoritesCubit>().searchFavorites(value);
                      },
                    ),
                  ),
                  Expanded(child: buildFavoritesList(state, locale)),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
