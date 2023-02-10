// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../repositories/firebase_document_repository.dart';

class FirebaseDocumentUsecase {
  final FirebaseDocumentRepository repository;

  FirebaseDocumentUsecase(
    this.repository,
  );

  Future<Either<FirebaseException, bool>> saveToken() {
    return repository.saveToken();
  }

  Future<Either<FirebaseException, bool>> declineNotifications() {
    return repository.declineNotifications();
  }

  Future<Either<FirebaseException, bool>> allowNotifications() {
    return repository.allowNotifications();
  }
}
