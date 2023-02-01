import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/constants/dot_env_manager.dart';
import '../../../core/lang/locale_keys.g.dart';
import '../../models/taboo_model.dart';

abstract class RemoteDataSource {
  Future<List<TabooModel>?> getAllTaboosFromFirebase();

  Future<bool> hasAnUpdate();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  FirebaseFirestore firestore = GetIt.I<FirebaseFirestore>();
  PackageInfo packageInfo = GetIt.I<PackageInfo>();

  @override
  Future<List<TabooModel>?> getAllTaboosFromFirebase() async {
    try {
      final database = firestore
          .collection(DotEnvManager.getBaseFirebaseDataColletionName()!);

      final tabooIDList = await database.get();

      print(tabooIDList.metadata);
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
        print('same versions');
        return false;
      }
      print('different versions. need update ');
      return true;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}
