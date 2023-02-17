import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  final _device = DeviceInfoPlugin();

  Future<String?> getDeviceID() async {
    String? id = '';
    if (Platform.isAndroid) {
      final androidInfo = await _device.androidInfo;
      id = androidInfo.id;
    }

    return id;
  }
}
