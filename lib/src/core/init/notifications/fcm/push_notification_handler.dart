import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/enums/preferences_enums.dart';
import '../../cache/local_manager.dart';
import '../config/notfication_config.dart';
import '../local/adapter/notification_adapter.dart';

final localManager = GetIt.instance<LocalManager>();
final flutterLocalNotificationsPlugin =
    GetIt.I<FlutterLocalNotificationsPlugin>();

//! this is not working
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('firebaseMessagingBackgroundHandler');

  final preferences = await SharedPreferences.getInstance();
  late NotificationAdapter notificationStatus;

  final permission =
      preferences.getBool(PreferencesKeys.NOTIFICATION_STATUS.toString());
  if (permission == null) {
    /** first time  opened the app*/
    notificationStatus = ActivetedNotifications();
  } else {
    if (permission) {
      notificationStatus = ActivetedNotifications();
    } else {
      notificationStatus = DeactivatedNotifications();
    }
  }

  // final notificationStatus = localManager.getCurrentAlertAdapter();

  if (notificationStatus is DeactivatedNotifications) {
    return;
  }
  final notification = message.notification;
  final android = message.notification?.android;

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(turkishChannel0);

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
          playSound: true,
          icon: '@mipmap/ic_launcher',

          // other properties...
        ),
      ),
    );
  }
}

class PushNotificationHandler {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final LocalManager localManager;

  PushNotificationHandler(
      this.flutterLocalNotificationsPlugin, this.localManager);

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(turkishChannel0);

    FirebaseMessaging.onMessage.listen(
      (message) async {
        final notificationStatus = localManager.getCurrentAlertAdapter();

        if (notificationStatus is DeactivatedNotifications) {
          return;
        }

        final notification = message.notification;
        final android = message.notification?.android;

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
        }
      },
    );
  }
}
