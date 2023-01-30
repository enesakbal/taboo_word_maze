import 'package:dartz/dartz.dart';
import '../entities/taboo.dart';
import '../repositories/taboo_repository.dart';

class TabooUsecase {
  final TabooRepository repository;

  const TabooUsecase(this.repository);

  Future<Either<Exception, List<Taboo>>> getAllTaboosFromFirebase() {
    return repository.getAllTaboosFromFirebase();
  }
}
