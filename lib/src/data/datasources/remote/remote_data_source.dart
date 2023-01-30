import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import '../../../core/constants/dot_env_manager.dart';
import '../../models/taboo_model.dart';

abstract class RemoteDataSource {
  Future<List<TabooModel>?> getAllTaboosFromFirebase();

  Future<bool> hasAnUpdate();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  FirebaseFirestore firestore = GetIt.I<FirebaseFirestore>();

  @override
  Future<List<TabooModel>?> getAllTaboosFromFirebase() async {
    try {
      final database = firestore
          .collection(DotEnvManager.getBaseFirebaseDataColletionName()!);
      final tabooIDList = await database.get();

      if (tabooIDList.size == 0) {
        return null;
      }
      final modelList = <TabooModel>[];

      for (final element in tabooIDList.docs) {
        final data = element.data();
        modelList.add(TabooModel.fromJson(data));
      }

      return modelList;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> hasAnUpdate() async {
    return false;
  }
}
