import 'package:flutter/material.dart';

abstract class NotificationAdapter {
  NotificationAdapterModel get model;
}

class NotificationAdapterModel {
  final IconData iconData;

  const NotificationAdapterModel({
    required this.iconData,
  });

  factory NotificationAdapterModel.active() => const NotificationAdapterModel(
        iconData: Icons.notifications_active_outlined,
      );

  factory NotificationAdapterModel.disable() => const NotificationAdapterModel(
        iconData: Icons.notifications_off_outlined,
      );
}

class ActivetedNotifications implements NotificationAdapter {
  @override
  NotificationAdapterModel get model => NotificationAdapterModel.active();
}

class DeactivatedNotifications implements NotificationAdapter {
  @override
  NotificationAdapterModel get model => NotificationAdapterModel.disable();
}
