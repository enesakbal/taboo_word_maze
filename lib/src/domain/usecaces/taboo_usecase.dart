import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../entities/taboo.dart';
import '../repositories/taboo_repository.dart';

class TabooUsecase {
  final TabooRepository repository;

  const TabooUsecase(this.repository);
  //* REMOTE
  Future<Either<FirebaseException, List<Taboo>>> getAllTaboosFromFirebase() {
    return repository.getAllTaboosFromFirebase();
  }

   Future<Either<FirebaseException, bool>>  hasAnUpdate(){
    return repository.hasAnUpdate();
  }

//*LOCAL

  Future<List<Taboo>> getAllTaboos() {
    return repository.getAllTaboos();
  }

  Future<void> insertANewTaboo({required Taboo newTaboo}) {
    return repository.insertNewTaboo(newTaboo: newTaboo);
  }

  Future<void> deleteTaboo({required Taboo deleteTaboo}) {
    return repository.deleteTaboo(deleteTaboo: deleteTaboo);
  }

  Future<void> updateTaboo({required Taboo newTaboo}) {
    return repository.updateTaboo(newTaboo: newTaboo);
  }

  Future<void> deleteAllTaboos() {
    return repository.deleteAllTaboos();
  }
}
