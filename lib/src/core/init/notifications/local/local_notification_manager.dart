import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../lang/language_manager.dart';
import '../config/notfication_config.dart';

class LocalNotificationManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  LocalNotificationManager(this.flutterLocalNotificationsPlugin);

  Future<void> initialize() async {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: initializationSettingsAndroid),
    );
  }

  Future<void> cancelAllAlerts() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> setAlerts() async {
    if (LanguageManager.currentLocale == LanguageManager().trLocale) {
      await _setAlert(channel: turkishChannel0, dayLater: 1);
      await _setAlert(channel: turkishChannel1, dayLater: 3);
      await _setAlert(channel: turkishChannel2, dayLater: 7);
      await _setAlert(channel: turkishChannel3, dayLater: 15);
    } else {
      await _setAlert(channel: englishChannel4, dayLater: 1);
      await _setAlert(channel: englishChannel5, dayLater: 3);
      await _setAlert(channel: englishChannel6, dayLater: 7);
      await _setAlert(channel: englishChannel7, dayLater: 15);
    }
  }

  Future<void> _setAlert({
    required AndroidNotificationChannel channel,
    required int dayLater,
  }) async {
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      int.parse(channel.id),
      null,
      channel.description,
      tz.TZDateTime.now(tz.local).add(Duration(days: dayLater)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
