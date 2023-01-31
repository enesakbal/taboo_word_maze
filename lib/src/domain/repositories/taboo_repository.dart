import 'package:dartz/dartz.dart';

import '../entities/taboo.dart';

abstract class TabooRepository {
  //* FIREBASE
  Future<Either<Exception, List<Taboo>>> getAllTaboosFromFirebase();

  //*DB
  Future<List<Taboo>> getAllTaboos();

  Future<void> insertNewTaboo({required Taboo newTaboo});

  Future<void> deleteTaboo({required Taboo deleteTaboo});

  Future<void> updateTaboo({required Taboo newTaboo});

  Future<void> deleteAllTaboos();
}
