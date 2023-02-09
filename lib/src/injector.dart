import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/cache/local_manager.dart';
import 'core/constants/local_db_constants.dart';
import 'core/enums/env_enums.dart';
import 'core/lang/adapter/language_adapter.dart';
import 'core/lang/language_manager.dart';
import 'core/notifications/adapter/notification_adapter.dart';
import 'core/notifications/notifications_manager.dart';
import 'core/notifier/theme_notifier.dart';
import 'core/theme/adapter/theme_adapter.dart';
import 'data/datasources/local/app_database.dart';
import 'data/datasources/remote/remote_data_source.dart';
import 'data/repositories/taboo_repository_impl.dart';
import 'domain/repositories/taboo_repository.dart';
import 'domain/usecaces/taboo_usecase.dart';
import 'presentation/bloc/home/adapter/settings_adapter.dart';
import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/splash/splash_bloc.dart';

final injector = GetIt.instance;

Future<void> init({required EnvModes mode}) async {
  //*ENVORIMENT
  if (mode == EnvModes.productMode) {
    await dotenv.load(fileName: '.env');
  } else {
    await dotenv.load(fileName: '.env.development');
    /* envorimentları güvenlik nedeniyle ayrı bir dosyada taşıdığımız için burada ön yükeleme yapmamız gerekiyor*/
    /* product ve development olmak üzere iki modu var */
  }

  //*LOCAL DB
  final database = await $FloorAppDatabase
      .databaseBuilder(LocalDBConstants.databaseName)
      .build();

  injector.registerSingleton<AppDatabase>(database);

  // await FlutterLocalNotificationsPlugin().initialize(InitializationSettings(android: AndroidInitializationSettings('')));
  // await database.tabooDao.deleteAllTaboos();

  //*CACHE
  final preferences = await SharedPreferences.getInstance();

  injector.registerLazySingleton(
    () => LocalManager(preferences: preferences),
  );

  //*THEME NOTIFIER
  final theme = GetIt.I<LocalManager>().getCurrentThemeMode();
  final localManager = GetIt.I<LocalManager>();

  injector.registerLazySingleton(
    () => ThemeModeNotifier(theme, localManager.changeThemeMode),
  );

  //*LANGUAGE MANAGER
  injector.registerLazySingleton(LanguageManager.new);

  //*NOTIFICATION
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  injector.registerLazySingleton<LocalNotificationManager>(
      () => LocalNotificationManager(flutterLocalNotificationsPlugin));
  await GetIt.I<LocalNotificationManager>().initialize();

  //*FIREBASE
  await Firebase.initializeApp();

  final messaging = FirebaseMessaging.instance;
  final firestore = FirebaseFirestore.instance;

  await firestore.clearPersistence();

  injector.registerLazySingleton<FirebaseMessaging>(() => messaging);
  injector.registerLazySingleton<FirebaseFirestore>(() => firestore);

  //*DATASOURCES
  injector.registerLazySingleton<RemoteDataSource>(RemoteDataSourceImpl.new);

  //*REPOSITORIES
  injector.registerLazySingleton<TabooRepository>(
    () => TabooRepositoryImpl(
      remoteDataSource: injector(),
      appDatabase: injector(),
    ),
  );

  //*USECASES
  injector.registerLazySingleton(() => TabooUsecase(injector()));

  //*ADAPTERS

  injector
      .registerLazySingleton<LocaleAdapter>(LanguageManager.getCurrentAdapter);
  injector
      .registerLazySingleton<ThemeAdapter>(localManager.getCurrentThemeMode);

  injector.registerLazySingleton<NotificationAdapter>(
      localManager.getCurrentAlertAdapter);

  injector.registerLazySingleton<ThemeSetting<ThemeAdapter>>(
      () => ThemeSetting(currentAdapter: injector()));

  injector.registerLazySingleton<LangSetting<LocaleAdapter>>(
      () => LangSetting(currentAdapter: injector()));

  injector.registerLazySingleton<NotificationSetting<NotificationAdapter>>(
      () => NotificationSetting(
            currentAdapter: injector(),
            localManager: injector(),
            notificationManager: injector(),
          ));

  //*BLOC
  injector.registerFactory(() => SplashBloc(injector()));
  injector.registerFactory(() => HomeBloc(injector(), injector(),injector()));

  //*PACKAGE INFO
  final packageInfo = await PackageInfo.fromPlatform();
  injector.registerLazySingleton<PackageInfo>(() => packageInfo);

  await messaging.requestPermission().then((value) async {
    if (value.authorizationStatus == AuthorizationStatus.authorized) {
      await localManager.setAlertPermission(value: true);
    } else {
      await localManager.setAlertPermission(value: false);
    }
  });
}
