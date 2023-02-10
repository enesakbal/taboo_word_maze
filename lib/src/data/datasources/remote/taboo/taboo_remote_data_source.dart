import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/constants/dot_env_manager.dart';
import '../../../../core/lang/locale_keys.g.dart';
import '../../../models/taboo_model.dart';

abstract class TabooRemoteDataSource {
  Future<List<TabooModel>?> getAllTaboosFromFirebase();

  Future<bool> hasAnUpdate();
}

class TabooRemoteDataSourceImpl implements TabooRemoteDataSource {
  FirebaseFirestore firestore;
  PackageInfo packageInfo;

  TabooRemoteDataSourceImpl({
    required this.firestore,
    required this.packageInfo,
  });

  @override
  Future<List<TabooModel>?> getAllTaboosFromFirebase() async {
    try {
      final database = firestore
          .collection(DotEnvManager.getBaseFirebaseDataColletionName()!);

      final tabooIDList = await database.get();

      if (tabooIDList.size == 0) {
        throw FirebaseException(
            plugin: 'getAllTaboosFromFirebase',
            message: LocaleKeys.errors_no_internet);
      }
      final modelList = <TabooModel>[];

      for (final element in tabooIDList.docs) {
        final data = element.data();
        modelList.add(TabooModel.fromJson(data));
      }
      log('Fetched data from firestore');

      return modelList;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> hasAnUpdate() async {
    try {
      //* Get current app version
      final currentVersion = packageInfo.version;
      //* Get current app version

      /******/

      //* Get live version
      final collectionName =
          DotEnvManager.getBaseFirebaseConfigColletionName()!;
      final documentName = DotEnvManager.getBaseFirebaseVersionDocumentName()!;
      final fieldName = DotEnvManager.getBaseFirebaseVersionFieldName()!;

      final database = firestore.collection(collectionName);

      final document = await database.doc(documentName).get();

      final liveVersion = await document.data()![fieldName] as String;
      //* Get live version

      if (liveVersion.contains(currentVersion)) {
        log('CURRENT VERSION : $currentVersion - LIVE VERSION : $liveVersion (SAME VERSIONS)');
        return false;
      }
      log('CURRENT VERSION : $currentVersion - LIVE VERSION : $liveVersion (DIFFERENT VERSIONS. NEED UPDATE)');
      return true;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}
