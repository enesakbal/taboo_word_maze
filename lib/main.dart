import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'src/config/router/app_router.dart';
import 'src/core/components/dialogs/start_game_dialog/bloc/start_game_dialog_bloc.dart';
import 'src/core/constants/app_constants.dart';
import 'src/core/constants/enums/env_enums.dart';
import 'src/core/init/lang/language_manager.dart';
import 'src/core/init/notifier/theme_notifier.dart';
import 'src/core/theme/app_theme.dart';
import 'src/injector.dart' as di;
import 'src/presentation/bloc/game/game_bloc.dart';
import 'src/presentation/bloc/home/home_bloc.dart';
import 'src/presentation/bloc/splash/splash_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await di.init(mode: EnvModes.developmentMode);
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<ThemeModeNotifier>(
            create: (context) => di.injector<ThemeModeNotifier>()),
      ],
      child: EasyLocalization(
        supportedLocales: LanguageManager().supportedLocales,
        path: ApplicationConstants.LANG_ASSET_PATH,
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return const MyApp();
          },
        ),
      ),
    ),
  );
}

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
  analytics: analytics,
  nameExtractor: (settings) {
    analytics
        .setCurrentScreen(
          screenName: settings.name ?? 'null',
          screenClassOverride: settings.name ?? 'null',
        )
        .then((value) => print(settings.name ?? 'null' 'nameExtractor'));
    return;
  },
  onError: (error) => print('${error.message}ERROR '),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.injector<SplashBloc>()),
        BlocProvider(create: (_) => di.injector<HomeBloc>()),
        BlocProvider(create: (_) => di.injector<GameBloc>()),
        BlocProvider(create: (_) => di.injector<StartGameDialogBloc>()),
      ],
      child: MaterialApp.router(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child!,
          );
        },
        title:
            LanguageManager.getCurrentAdapter().model.locale.toLanguageTag() ==
                    'TR'
                ? 'Tabu\nKelime Labirenti'
                : 'Taboo\nWord Maze',
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        // themeMode: Provider.of<ThemeModeNotifier>(context, listen: true)
        //     .currentThemeAdapter
        //     .model
        //     .themeMode,
        routerDelegate: AutoRouterDelegate(
          router,
          navigatorObservers: () => [
            observer,
          ],
        ),
        routeInformationParser: router.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        localeResolutionCallback: LanguageManager.localeResolutionCallback,
      ),
    );
  }
}
