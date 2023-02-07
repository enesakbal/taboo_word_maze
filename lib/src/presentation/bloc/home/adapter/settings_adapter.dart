import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../../core/cache/local_manager.dart';
import '../../../../core/lang/adapter/language_adapter.dart';
import '../../../../core/lang/language_manager.dart';
import '../../../../core/notifications/adapter/notification_adapter.dart';
import '../../../../core/notifications/notifications_manager.dart';
import '../../../../core/notifier/theme_notifier.dart';

abstract class SettingsAdapter<T> {
  T currentAdapter;

  Future<void> changeState(BuildContext context);

  SettingsAdapter({
    required this.currentAdapter,
  });
}

class ThemeSetting<ThemeAdapter> extends SettingsAdapter<ThemeAdapter> {
  ThemeSetting({
    required super.currentAdapter,
  });

  @override
  Future<void> changeState(BuildContext context) async {
    final provider = Provider.of<ThemeModeNotifier>(context, listen: false);

    await provider.changeTheme();
    currentAdapter = provider.currentThemeAdapter as ThemeAdapter;
  }
}

class LangSetting<LocaleAdapter> extends SettingsAdapter<LocaleAdapter> {
  LangSetting({required super.currentAdapter});

  @override
  Future<void> changeState(BuildContext context) async {
    final turkish = TurkishLocale().model.locale;
    final english = EnglishLocale().model.locale;

    if (currentAdapter is TurkishLocale) {
      await context.setLocale(english);
      currentAdapter = EnglishLocale() as LocaleAdapter;
    } else if (currentAdapter is EnglishLocale) {
      currentAdapter = TurkishLocale() as LocaleAdapter;
      await context.setLocale(turkish);
    }
  }
}

class NotificationSetting<NotificationAdapter>
    extends SettingsAdapter<NotificationAdapter> {
  LocalNotificationManager notificationManager;
  LocalManager localManager;

  NotificationSetting({
    required super.currentAdapter,
    required this.notificationManager,
    required this.localManager,
  });

  @override
  Future<void> changeState(BuildContext context) async {
    if (currentAdapter is ActivetedNotifications) {
      await notificationManager.cancelAllAlerts();
      currentAdapter = DeactivetedNotifications() as NotificationAdapter;
      log('Cancelled all alerts');
    } else if (currentAdapter is DeactivetedNotifications) {
      await notificationManager.setAlerts();
      currentAdapter = ActivetedNotifications() as NotificationAdapter;
      log('Setted all alerts');
    }
  }

  Future<void> cancelAllAlertsAndSetAlerts() async {
    await notificationManager.cancelAllAlerts().whenComplete(
      () {
        log('Cancelled all alerts');
        return notificationManager.setAlerts().whenComplete(
              () => log('Setted all alerts'),
            );
      },
    );
  }
}
