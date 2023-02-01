import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../entities/taboo.dart';

abstract class TabooRepository {
  //* FIREBASE
  Future<Either<FirebaseException, List<Taboo>>> getAllTaboosFromFirebase();

  Future<Either<FirebaseException, bool>> hasAnUpdate();

  //*DB
  Future<List<Taboo>> getAllTaboos();

  Future<void> insertNewTaboo({required Taboo newTaboo});

  Future<void> deleteTaboo({required Taboo deleteTaboo});

  Future<void> updateTaboo({required Taboo newTaboo});

  Future<void> deleteAllTaboos();
}
