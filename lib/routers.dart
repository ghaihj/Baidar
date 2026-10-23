import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/view/screen/homepage.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(initialLocation: '/',

 routes: [
  GoRoute(path: '/' , builder: (context, state) => Homepage()),
  GoRoute(path: AppRoute.homepage , builder: (context, state) => Homepage())
 ]);
