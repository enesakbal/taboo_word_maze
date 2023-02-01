import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvManager {
  static String? getBaseFirebaseUserColletionName() =>
      dotenv.env['BASE_FIREBASE_USER_COLLECTION'];

  static String? getBaseFirebaseDataColletionName() =>
      dotenv.env['BASE_FIREBASE_DATA_COLLECTION'];

  static String? getBaseFirebaseConfigColletionName() =>
      dotenv.env['BASE_FIREBASE_CONFIG_COLLECTION'];

  static String? getBaseFirebaseVersionDocumentName() =>
      dotenv.env['BASE_FIREBASE_VERSION_DOCUMENT'];

  static String? getBaseFirebaseVersionFieldName() =>
      dotenv.env['BASE_FIREBASE_VERSION_FIELD_NAME'];
}
