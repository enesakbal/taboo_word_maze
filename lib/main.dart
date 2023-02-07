import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:taboo_word_maze/src/core/lang/language_manager.dart';
import 'package:taboo_word_maze/src/presentation/bloc/lang/lang_bloc.dart';

import 'src/config/router/app_router.dart';
import 'src/core/constants/app_constants.dart';
import 'src/core/enums/env_enums.dart';
import 'src/core/theme/app_theme.dart';
import 'src/injector.dart' as di;
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
    EasyLocalization(
      supportedLocales: LanguageManager().supportedLocales,
      path: ApplicationConstants.LANG_ASSET_PATH,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return const MyApp();
        },
      ),
    ),
  );
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.injector<SplashBloc>()),
        BlocProvider(create: (_) => di.injector<HomeBloc>()),
        BlocProvider(create: (_) => di.injector<LangBloc>()),
      ],
      child: MaterialApp.router(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child!,
          );
        },
        title: 'Taboo\nWord Maze',
        theme: AppTheme.theme,
        routerDelegate: router.delegate(),
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
