import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../domain/repositories/firebase_document_repository.dart';
import '../datasources/remote/firebase_document/firebase_document_remote_data_source.dart';

class FirebaseDocumentRepositoryImpl implements FirebaseDocumentRepository {
  final FirebaseDocumentRemoteDataSource remoteDataSource;

  FirebaseDocumentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<FirebaseException, bool>> saveToken() async {
    try {
      await remoteDataSource.saveToken();
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<FirebaseException, bool>> allowNotifications() async {
    try {
      await remoteDataSource.allowNotifications();
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<FirebaseException, bool>> declineNotifications() async {
    try {
      await remoteDataSource.declineNotifications();
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }
}
