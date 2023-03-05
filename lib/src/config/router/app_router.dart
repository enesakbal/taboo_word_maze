import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/team.dart';
import '../../presentation/view/edit_view.dart';
import '../../presentation/view/game_view.dart';
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
      transitionsBuilder: zoomInTransition,
      durationInMilliseconds: 1500,
      // initial: true,
    ),
    CustomRoute(
      page: GameView,
      path: '/game',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 400,
      // initial: true,
    ),
    CustomRoute(
      page: EditView,
      path: '/edit',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 400,
      // initial: true,
    ),
  ],
)
class AppRouter extends _$AppRouter {}

Widget zoomInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  final opacity = Tween<double>(
    end: 1,
    begin: 0,
  ).chain(CurveTween(curve: Curves.fastOutSlowIn)).animate(animation);

  final scale = Tween<double>(
    end: 1,
    begin: 1.20,
  ).chain(CurveTween(curve: Curves.fastOutSlowIn)).animate(animation);

  return FadeTransition(
    opacity: opacity,
    child: ScaleTransition(
      scale: scale,
      child: child,
    ),
  );
}

final router = AppRouter();
