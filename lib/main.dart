import 'package:baider_app/bloc/auth/login/logincubit.dart';
import 'package:baider_app/bloc/auth/signup/signupcubit.dart';
import 'package:baider_app/di/injection.dart';
import 'package:baider_app/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LoginCubit>()),
        BlocProvider(create: (_) => getIt<Signupcubit>()),
      ],

      child: MaterialApp.router(
        title: 'Bidar',
        theme: ThemeData(colorScheme: ColorScheme.light()),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}



