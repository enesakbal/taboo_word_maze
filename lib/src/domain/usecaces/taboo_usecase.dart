import 'package:dartz/dartz.dart';
import '../entities/taboo.dart';
import '../repositories/taboo_repository.dart';

class TabooUsecase {
  final TabooRepository repository;

  const TabooUsecase(this.repository);

  Future<Either<Exception, List<Taboo>>> getAllTaboosFromFirebase() {
    return repository.getAllTaboosFromFirebase();
  }

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

  Future<void> dropTabooTable() {
    return repository.dropTabooTable();
  }
}
