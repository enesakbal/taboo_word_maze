import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvManager {
  static String? getBaseFirebaseUserColletionName() =>
      dotenv.env['BASE_FIREBASE_USER_COLLECTION'];

  static String? getBaseFirebaseDataColletionName() =>
      dotenv.env['BASE_FIREBASE_DATA_COLLECTION'];
}
