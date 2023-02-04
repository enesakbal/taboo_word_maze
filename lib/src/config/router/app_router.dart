import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../presentation/view/home_view.dart';
import '../../presentation/view/splash_view.dart';

part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  // * for names
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashView,
      path: '/splash',
      initial: true,
    ),
    CustomRoute(
      page: HomeView,
      path: '/home',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 800,
    )
  ],
)
class AppRouter extends _$AppRouter {}

final router = AppRouter();
