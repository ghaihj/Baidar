// lib/view/screen/main_layout.dart
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    // تحديد التبويب النشط من المسار
    int currentIndex = 0;
    if (location == AppRoute.favouretpage) currentIndex = 1;
    if (location == AppRoute.profilepage) currentIndex = 2;

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.grey[50],
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go(AppRoute.homepage);
                  break;
                case 1:
                  context.go(AppRoute.favouretpage);
                  break;
                case 2:
                  context.go(AppRoute.profilepage);
                  break;
              }
            },
            selectedItemColor: AppColors.primarycolor,
            unselectedItemColor: AppColors.gray1,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: AppTranslations.tr(locale, 'nav_home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                activeIcon: Icon(Icons.favorite),
                label: AppTranslations.tr(locale, 'nav_favorites'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: AppTranslations.tr(locale, 'nav_profile'),
              ),
            ],
          ),
        );
      },
    );
  }
}
