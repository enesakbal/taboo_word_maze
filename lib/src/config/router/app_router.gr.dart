// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const SplashView(),
      );
    },
    HomeRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
        transitionsBuilder: zoomInTransition,
        durationInMilliseconds: 1500,
        opaque: true,
        barrierDismissible: false,
      );
    },
    GameRoute.name: (routeData) {
      final args = routeData.argsAs<GameRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: GameView(
          key: args.key,
          duration: args.duration,
          team1: args.team1,
          team2: args.team2,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 400,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const EditView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 400,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/home',
          fullMatch: true,
        ),
        RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        RouteConfig(
          GameRoute.name,
          path: '/game',
        ),
        RouteConfig(
          EditRoute.name,
          path: '/edit',
        ),
      ];
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [GameView]
class GameRoute extends PageRouteInfo<GameRouteArgs> {
  GameRoute({
    Key? key,
    required int duration,
    required Team team1,
    required Team team2,
  }) : super(
          GameRoute.name,
          path: '/game',
          args: GameRouteArgs(
            key: key,
            duration: duration,
            team1: team1,
            team2: team2,
          ),
        );

  static const String name = 'GameRoute';
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    required this.duration,
    required this.team1,
    required this.team2,
  });

  final Key? key;

  final int duration;

  final Team team1;

  final Team team2;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, duration: $duration, team1: $team1, team2: $team2}';
  }
}

/// generated route for
/// [EditView]
class EditRoute extends PageRouteInfo<void> {
  const EditRoute()
      : super(
          EditRoute.name,
          path: '/edit',
        );

  static const String name = 'EditRoute';
}
