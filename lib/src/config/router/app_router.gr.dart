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
    NGameRoute.name: (routeData) {
      final args = routeData.argsAs<NGameRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: NGameView(
          key: args.key,
          duration: args.duration,
        ),
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
          NGameRoute.name,
          path: '/gamenew',
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
/// [NGameView]
class NGameRoute extends PageRouteInfo<NGameRouteArgs> {
  NGameRoute({
    Key? key,
    required int duration,
  }) : super(
          NGameRoute.name,
          path: '/gamenew',
          args: NGameRouteArgs(
            key: key,
            duration: duration,
          ),
        );

  static const String name = 'NGameRoute';
}

class NGameRouteArgs {
  const NGameRouteArgs({
    this.key,
    required this.duration,
  });

  final Key? key;

  final int duration;

  @override
  String toString() {
    return 'NGameRouteArgs{key: $key, duration: $duration}';
  }
}
