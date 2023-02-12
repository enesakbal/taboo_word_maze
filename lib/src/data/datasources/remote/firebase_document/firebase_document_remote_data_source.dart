import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/constants/dot_env_manager.dart';
import '../../../../core/device_info/device_info.dart';

abstract class FirebaseDocumentRemoteDataSource {
  Future<void> saveToken();
  Future<void> declineNotifications();
  Future<void> allowNotifications();
}

class FirebaseDocumentRemoteDataSourceImpl
    implements FirebaseDocumentRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseMessaging messaging;
  final PackageInfo packageInfo;
  final DeviceInfo deviceInfo;

  FirebaseDocumentRemoteDataSourceImpl({
    required this.firestore,
    required this.messaging,
    required this.packageInfo,
    required this.deviceInfo,
  });

  @override
  Future<void> saveToken() async {
    try {
      final database = firestore
          .collection(DotEnvManager.getBaseFirebaseUserColletionName()!);
      final fcmToken = await messaging.getToken();

      final deviceID = await deviceInfo.getDeviceID();

      final map = {
        'version': packageInfo.version,
        'lastEntry': FieldValue.serverTimestamp(),
        'token': fcmToken,
      };

      await database.doc(deviceID).set(map);
      log('Saved token to firestore');
    } on FirebaseException catch (_) {
      log('Error while save token to firestore');
      rethrow;
    }
  }

  @override
  Future<void> allowNotifications() async {
    try {
      final database = firestore
          .collection(DotEnvManager.getBaseFirebaseUserColletionName()!);
      final deviceID = await deviceInfo.getDeviceID();

      await database.doc(deviceID).get();
      //* for catching offline

      final fcmToken = await messaging.getToken();

      final map = {
        'token': fcmToken,
      };

      await database.doc(deviceID).update(map);
      //** if user want recieve notification, we must fill with his token on firestore documents  */

      log('Allowed firebase push notifications');
    } on FirebaseException catch (_) {
      log('Error while allowing firebase push notifications');
      rethrow;
    }
  }

  @override
  Future<void> declineNotifications() async {
    try {
      final database = firestore
          .collection(DotEnvManager.getBaseFirebaseUserColletionName()!);
      final deviceID = await deviceInfo.getDeviceID();

      await database.doc(deviceID).get();
      //* for catching offline

      final map = {
        'token': '',
      };

      await database.doc(deviceID).update(map);
      //** if user dont want recieve notification, we must empty his token on firestore documents  */

      log('Declined firebase push notifications');
    } on FirebaseException catch (_) {
      log('Error while declining firebase push notifications');
      rethrow;
    }
  }
}
