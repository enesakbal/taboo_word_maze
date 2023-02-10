import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../core/lang/locale_keys.g.dart';
import '../../domain/entities/taboo.dart';
import '../../domain/repositories/taboo_repository.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/taboo/taboo_remote_data_source.dart';

class TabooRepositoryImpl extends TabooRepository {
  final AppDatabase appDatabase;
  final TabooRemoteDataSource remoteDataSource;

  TabooRepositoryImpl(
      {required this.appDatabase, required this.remoteDataSource});

  //* REMOTE

  @override
  Future<Either<FirebaseException, List<Taboo>>>
      getAllTaboosFromFirebase() async {
    try {
      final result = await remoteDataSource.getAllTaboosFromFirebase();

      if (result == null) {
        //* result null because response length == 0
        //* no internet or no data.
        return Left(
          FirebaseException(
            plugin: 'getAllTaboosFromFirebase',
            message: LocaleKeys.errors_no_internet.tr(),
          ),
        );
      }

      final data = result.map((e) => e.toEntity()).toList();

      return Right(data);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<FirebaseException, bool>> hasAnUpdate() async {
    try {
      final result = await remoteDataSource.hasAnUpdate();

      if (result) {
        return Right(result);
      } else {
        return Right(result);
      }
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  //* LOCAL

  @override
  Future<List<Taboo>> getAllTaboos() async {
    return appDatabase.tabooDao.getAllTaboo();
  }

  @override
  Future<void> insertNewTaboo({required Taboo newTaboo}) {
    return appDatabase.tabooDao.insertANewTaboo(newTaboo);
  }

  @override
  Future<void> deleteTaboo({required Taboo deleteTaboo}) {
    return appDatabase.tabooDao.deleteATaboo(deleteTaboo);
  }

  @override
  Future<void> updateTaboo({required Taboo newTaboo}) {
    return appDatabase.tabooDao.updateATaboo(newTaboo);
  }

  @override
  Future<void> deleteAllTaboos() {
    return appDatabase.tabooDao.deleteAllTaboos();
  }
}
