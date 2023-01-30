import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'core/constants/local_db_constants.dart';
import 'core/enums/env_enums.dart';
import 'core/lang/language_manager.dart';
import 'data/datasources/local/app_database.dart';
import 'data/datasources/remote/remote_data_source.dart';
import 'data/repositories/taboo_repository_impl.dart';
import 'domain/repositories/taboo_repository.dart';
import 'domain/usecaces/taboo_usecase.dart';
import 'presentation/bloc/splash/splash_bloc.dart';

final injector = GetIt.instance;

Future<void> init({required EnvModes mode}) async {
  //ENVORIMENT
  if (mode == EnvModes.productMode) {
    await dotenv.load(fileName: '.env');
  } else {
    await dotenv.load(fileName: '.env.development');
    /* envorimentları güvenlik nedeniyle ayrı bir dosyada taşıdığımız için burada ön yükeleme yapmamız gerekiyor*/
    /* product ve development olmak üzere iki modu var */
  }

  // LOCAL DB
  final database = await $FloorAppDatabase
      .databaseBuilder(LocalDBConstants.databaseName)
      .build();

      
  injector.registerSingleton<AppDatabase>(database);

  //FIREBASE
  await Firebase.initializeApp();

  final messaging = FirebaseMessaging.instance;
  final firestore = FirebaseFirestore.instance;

  injector.registerLazySingleton<FirebaseMessaging>(() => messaging);
  injector.registerLazySingleton<FirebaseFirestore>(() => firestore);

  //DATASOURCES
  injector.registerLazySingleton<RemoteDataSource>(RemoteDataSourceImpl.new);

  //REPOSITORIES
  injector.registerLazySingleton<TabooRepository>(
    () => TabooRepositoryImpl(
      remoteDataSource: injector(),
      appDatabase: injector(),
    ),
  );

  //USECASES
  injector.registerLazySingleton(() => TabooUsecase(injector()));

  //BLOC
  injector.registerFactory(() => SplashBloc(injector()));

  //LANGUAGE MANAGER
  injector.registerLazySingleton(LanguageManager.new);
}
