import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/components/dialogs/start_game_dialog/bloc/start_game_dialog_bloc.dart';
import 'core/constants/enums/env_enums.dart';
import 'core/constants/local_db_constants.dart';
import 'core/init/cache/local_manager.dart';
import 'core/init/device_info/device_info.dart';
import 'core/init/lang/adapter/language_adapter.dart';
import 'core/init/lang/language_manager.dart';
import 'core/init/notifications/fcm/push_notification_handler.dart';
import 'core/init/notifications/local/adapter/notification_adapter.dart';
import 'core/init/notifications/local/local_notification_manager.dart';
import 'core/init/notifier/theme_notifier.dart';
import 'core/theme/adapter/theme_adapter.dart';
import 'data/datasources/local/app_database.dart';
import 'data/datasources/remote/firebase_document/firebase_document_remote_data_source.dart';
import 'data/datasources/remote/taboo/taboo_remote_data_source.dart';
import 'data/repositories/firebase_document_repository_impl.dart';
import 'data/repositories/taboo_repository_impl.dart';
import 'domain/repositories/firebase_document_repository.dart';
import 'domain/repositories/taboo_repository.dart';
import 'domain/usecaces/firebase_document_usecase.dart';
import 'domain/usecaces/taboo_usecase.dart';
import 'presentation/bloc/edit/edit_bloc.dart';
import 'presentation/bloc/game/game_bloc.dart';
import 'presentation/bloc/home/adapter/settings_adapter.dart';
import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/splash/splash_bloc.dart';

final injector = GetIt.instance;

Future<void> init({required EnvModes mode}) async {
  if (mode == EnvModes.productMode) {
    await dotenv.load(fileName: '.env');
  } else if (mode == EnvModes.developmentMode) {
    await dotenv.load(fileName: '.env.development');
    /* envorimentları güvenlik nedeniyle ayrı bir dosyada taşıdığımız için burada ön yükeleme yapmamız gerekiyor*/
    /* product ve development olmak üzere iki modu var */
  }

  //***************************- LOCAL DB -*****************************//
  //*------------------------------------------------------------------*//
  //*------------------------------------------------------------------*//
  final database = await $FloorAppDatabase
      .databaseBuilder(LocalDBConstants.databaseName)
      .build();
  injector.registerSingleton<AppDatabase>(database);

  // await FlutterLocalNotificationsPlugin().initialize(InitializationSettings(android: AndroidInitializationSettings('')));
  // await database.tabooDao.deleteAllTaboos();
  //*------------------------------------------------------------------*//
  //*------------------------------------------------------------------*//
  //***************************- LOCAL DB -*****************************//

  //****************************- CACHE -*******************************//
  //*------------------------------------------------------------------*//
  //*------------------------------------------------------------------*//
  final preferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton<LocalManager>(
    () => LocalManager(preferences: preferences),
  );

  final localManager = GetIt.I<LocalManager>();
  //*------------------------------------------------------------------*//
  //*------------------------------------------------------------------*//
  //****************************- CACHE -*******************************//

  //*************************- THEME NOTIFIER -*************************//
  //*------------------------------------------------------------------*//
  //*------------------------------------------------------------------*//
  final theme = localManager.getCurrentThemeMode();

  injector.registerLazySingleton<ThemeModeNotifier>(
    () => ThemeModeNotifier(theme, localManager.changeThemeMode),
  );
  //*------------------------------------------------------------------*//
  //*------------------------------------------------------------------*//
  //************************- THEME NOTIFIER -************************//

  //************************- LANGUAGE MANAGER -***********************//
  //*------------------------------------------------------------------*//
  //*------------------------------------------------------------------*//

  injector.registerLazySingleton(LanguageManager.new);

  //*------------------------------------------------------------------*//
  //*------------------------------------------------------------------*//
  //***********************- LANGUAGE MANAGER -************************//

  //***********************- LOCAL NOTIFICATION -**********************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  injector.registerLazySingleton<LocalNotificationManager>(
      () => LocalNotificationManager(flutterLocalNotificationsPlugin));
  await injector<LocalNotificationManager>().initialize();

  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //***********************- LOCAL NOTIFICATION -**********************//

  //****************************- FIREBASE -****************************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

  await Firebase.initializeApp();

  final messaging = FirebaseMessaging.instance;
  final firestore = FirebaseFirestore.instance;

  try {
    await firestore.clearPersistence();
    //* Clears any persisted data for the current instance.
  } on Exception catch (_) {}
  // firestore.settings = const Settings(persistenceEnabled: false,);

  injector.registerLazySingleton<FirebaseMessaging>(() => messaging);
  injector.registerLazySingleton<FirebaseFirestore>(() => firestore);

  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //****************************- FIREBASE -****************************//

  //*****************- FIREBASE NOTIFICATION HANDLER -******************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

  injector.registerLazySingleton<PushNotificationHandler>(() =>
      PushNotificationHandler(flutterLocalNotificationsPlugin, localManager));
  await injector<PushNotificationHandler>().initialize();

  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //*****************- FIREBASE NOTIFICATION HANDLER -******************//

  //***************************- DATASOURCES -**************************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

  injector.registerLazySingleton<TabooRemoteDataSource>(() =>
      TabooRemoteDataSourceImpl(
          firestore: injector(), packageInfo: injector()));

  injector.registerLazySingleton<FirebaseDocumentRemoteDataSource>(
    () => FirebaseDocumentRemoteDataSourceImpl(
      firestore: injector(),
      messaging: injector(),
      packageInfo: injector(),
      deviceInfo: injector(),
    ),
  );

  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //***************************- DATASOURCES -**************************//

  //**************************- REPOSITORIES -**************************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

  injector.registerLazySingleton<TabooRepository>(
    () => TabooRepositoryImpl(
      remoteDataSource: injector(),
      appDatabase: injector(),
    ),
  );
  injector.registerLazySingleton<FirebaseDocumentRepository>(
    () => FirebaseDocumentRepositoryImpl(
      remoteDataSource: injector(),
    ),
  );

  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //**************************- REPOSITORIES -**************************//

  //****************************- USECASES -****************************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

  injector.registerLazySingleton(() => TabooUsecase(injector()));
  injector.registerLazySingleton(() => FirebaseDocumentUsecase(injector()));

  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //****************************- USECASES -****************************//

  //******************************- BLOC -******************************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

  injector.registerFactory(() => SplashBloc(injector(), injector()));
  injector.registerFactory(() => HomeBloc(injector(), injector(), injector()));
  injector.registerFactory(() => GameBloc(injector()));
  injector.registerFactory(() => EditBloc(injector()));
  injector.registerFactory(StartGameDialogBloc.new);

  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //******************************- BLOC -******************************//

  //****************************- ADAPTERS -****************************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

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
      notificationHandler: injector(),
      firebaseDocumentUsecase: injector(),
    ),
  );

  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //****************************- ADAPTERS -****************************//

  //**********************- FIREBASE PERMISSION -***********************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

  await messaging.requestPermission().then((value) async {
    //* for android 13 ++
    if (value.authorizationStatus == AuthorizationStatus.authorized) {
      if (localManager.getCurrentAlertAdapter() is DeactivatedNotifications) {
        await localManager.setAlertPermission(value: false);
      } else if (localManager.getCurrentAlertAdapter()
          is ActivetedNotifications) {
        await localManager.setAlertPermission(value: true);
      }
    } else {
      await localManager.setAlertPermission(value: false);
    }
  });

  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //**********************- FIREBASE PERMISSION -***********************//

  //**************************- PACKAGE INFO -**************************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

  final packageInfo = await PackageInfo.fromPlatform();
  injector.registerLazySingleton<PackageInfo>(() => packageInfo);
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //**************************- PACKAGE INFO -**************************//

  //**************************- DEVICE INFO -***************************//
  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/

  injector.registerLazySingleton<DeviceInfo>(DeviceInfo.new);

  //*-------------------------------------------------------------------*/
  //*-------------------------------------------------------------------*/
  //**************************- DEVICE INFO -***************************//

  try {
    log('*****************INITIAL STATES******************');

    final notificationStatus = localManager.getCurrentAlertAdapter();
    log('NOTIFICATION STATUS : ${notificationStatus.runtimeType}');

    final currentTheme = localManager.getCurrentThemeMode();
    log('THEME : ${currentTheme.runtimeType}');

    final currentLang = LanguageManager.getCurrentAdapter();
    log('LANGUAGE : ${currentLang.runtimeType}');

    log('*****************INITIAL STATES******************');

    if (mode == EnvModes.developmentMode) {
      log('MODE : Development');
      final fcmToken = await messaging.getToken();
      if (fcmToken == null) {}
      log('FCM TOKEN : $fcmToken');
    } else {
      log('MODE : Product');
    }
  } on Exception catch (_) {}
}
