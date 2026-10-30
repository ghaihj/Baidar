import 'package:baider_app/bloc/auth/checkauth/authcubit.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/bloc/settings/theme_cubit.dart';
import 'package:baider_app/di/injection.dart';
import 'package:baider_app/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  await getIt<AuthCubit>().checkAuth();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<ThemeCubit>()),
        BlocProvider.value(value: getIt<LocaleCubit>()),
        // BlocProvider.value(value: getIt<AuthCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                title: 'Bidar',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(colorScheme: const ColorScheme.light()),
                darkTheme: ThemeData(colorScheme: const ColorScheme.dark()),
                themeMode: themeMode,
                locale: locale,
                supportedLocales: const [Locale('ar'), Locale('en')],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                routerConfig: router,
              );
            },
          );
        },
      ),
    );
  }
}
