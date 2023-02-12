import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

AndroidNotificationChannel turkishChannel0 = const AndroidNotificationChannel(
  '0', // id
  'notification0', // name
  description:
      'Tabuları keşfet, zekânını ve becerilerini test et!', // description
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
);
AndroidNotificationChannel turkishChannel1 = const AndroidNotificationChannel(
  '1', // id
  'notification1', // name
  description:
      'Tabularla zamanını verimli kullan, eğlen ve öğren!', // description
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
);
AndroidNotificationChannel turkishChannel2 = const AndroidNotificationChannel(
  '2', // id
  'notification0', // name
  description:
      'Tabuları keşfet, zekânını ve becerilerini test et!', // description
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
);
AndroidNotificationChannel turkishChannel3 = const AndroidNotificationChannel(
  '3', // id
  'notification1', // name
  description:
      'Tabularla zamanını verimli kullan, eğlen ve öğren!', // description
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
);

AndroidNotificationChannel englishChannel4 = const AndroidNotificationChannel(
  '4', // id
  'notification2', // name
  description:
      'Discover the taboo, test your intelligence and skills!', // description
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
);
AndroidNotificationChannel englishChannel5 = const AndroidNotificationChannel(
  '5', // id
  'notification3', // name
  description:
      'Use your time efficiently with the taboo, have fun and learn!', // description
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
);
AndroidNotificationChannel englishChannel6 = const AndroidNotificationChannel(
  '6', // id
  'notification2', // name
  description:
      'Discover the taboo, test your intelligence and skills!', // description
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
);
AndroidNotificationChannel englishChannel7 = const AndroidNotificationChannel(
  '7', // id
  'notification3', // name
  description:
      'Use your time efficiently with the taboo, have fun and learn!', // description
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
);
