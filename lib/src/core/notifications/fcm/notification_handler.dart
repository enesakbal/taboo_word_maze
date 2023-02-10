import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../cache/local_manager.dart';
import '../config/notfication_config.dart';
import '../local/adapter/notification_adapter.dart';

class NotificationHandler {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final LocalManager localManager;

  NotificationHandler(this.flutterLocalNotificationsPlugin, this.localManager);

  Future<void> initialize() async {
    final notificationStatus = localManager.getCurrentAlertAdapter();

    if (notificationStatus is DeactivatedNotifications) {
      return;
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(turkishChannel0);

    FirebaseMessaging.onMessage.listen(
      (message) async {
        final notification = message.notification;
        final android = message.notification?.android;

        if (notificationStatus is DeactivatedNotifications) {
          print('girmedi');
          return;
        }

        print('onMessage');

        if (notification != null && android != null) {
          await flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                turkishChannel0.id,
                turkishChannel0.name,
                channelDescription: turkishChannel0.description,
                icon: '@mipmap/ic_launcher',
                // other properties...
              ),
            ),
          );
          print('test');
        }
      },
    );
  }
}
