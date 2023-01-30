import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'src/config/router/app_router.dart';
import 'src/core/constants/app_constants.dart';
import 'src/core/enums/env_enums.dart';
import 'src/core/lang/language_manager.dart';
import 'src/injector.dart' as di;
import 'src/presentation/bloc/splash/splash_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await di.init(mode: EnvModes.developmentMode);

  final lang = di.injector<LanguageManager>();

  runApp(
    EasyLocalization(
      supportedLocales: lang.supportedLocales,
      startLocale: lang.trLocale,
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
        ],
        child: MaterialApp.router(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!,
            );
          },
          title: 'Taboo\nWord Maze',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerDelegate: router.delegate(),
          routeInformationParser: router.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
