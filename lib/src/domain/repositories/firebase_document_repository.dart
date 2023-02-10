import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class FirebaseDocumentRepository {
  Future<Either<FirebaseException, bool>> saveToken();
  Future<Either<FirebaseException, bool>> declineNotifications();
  Future<Either<FirebaseException, bool>> allowNotifications();
}
