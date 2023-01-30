import 'package:dartz/dartz.dart';

import '../../domain/entities/taboo.dart';
import '../../domain/repositories/taboo_repository.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/remote_data_source.dart';

class TabooRepositoryImpl extends TabooRepository {
  final AppDatabase appDatabase;
  final RemoteDataSource remoteDataSource;

  TabooRepositoryImpl(
      {required this.appDatabase, required this.remoteDataSource});

  @override
  Future<Either<Exception, List<Taboo>>> getAllTaboosFromFirebase() async {
    try {
      final result = await remoteDataSource.getAllTaboosFromFirebase();

      if (result == null) {
        return Left(Exception('There is no data'));
      }

      final convertedEntites = result.map((e) => e.toEntity()).toList();
      return Right(convertedEntites);
    } on Exception catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<List<Taboo>> getAllTaboos() async {
    return appDatabase.tabo.getAllTaboo();
  }

  @override
  Future<void> insertNewTaboo({required Taboo newTaboo}) {
    return appDatabase.tabo.insertANewTaboo(newTaboo);
  }

  @override
  Future<void> deleteTaboo({required Taboo deleteTaboo}) {
    return appDatabase.tabo.deleteATaboo(deleteTaboo);
  }

  @override
  Future<void> updateTaboo({required Taboo newTaboo}) {
    return appDatabase.tabo.updateATaboo(newTaboo);
  }
}
