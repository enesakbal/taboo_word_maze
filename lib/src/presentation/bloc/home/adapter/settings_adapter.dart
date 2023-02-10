import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/cache/local_manager.dart';
import '../../../../core/components/toast/toast_manager.dart';
import '../../../../core/lang/adapter/language_adapter.dart';
import '../../../../core/lang/locale_keys.g.dart';
import '../../../../core/notifications/local/adapter/notification_adapter.dart';
import '../../../../core/notifications/local/local_notification_manager.dart';
import '../../../../core/notifier/theme_notifier.dart';
import '../../../../core/theme/adapter/theme_adapter.dart';

abstract class ISettings<T> {
  T currentAdapter;

  Future<void> changeState(BuildContext context);

  ISettings({
    required this.currentAdapter,
  });
}

class ThemeSetting<ThemeAdapter> extends ISettings<ThemeAdapter> {
  ThemeSetting({
    required super.currentAdapter,
  });

  @override
  Future<void> changeState(BuildContext context) async {
    final provider = Provider.of<ThemeModeNotifier>(context, listen: false);

    await provider.changeTheme().then((value) {
      currentAdapter = provider.currentThemeAdapter as ThemeAdapter;
      if (currentAdapter is LightTheme) {
        log('changed theme to  LightTheme');
      } else if (currentAdapter is DarkTheme) {
        log('changed theme to  DarkTheme');
      }
    });
  }
}

class LangSetting<LocaleAdapter> extends ISettings<LocaleAdapter> {
  LangSetting({required super.currentAdapter});

  @override
  Future<void> changeState(BuildContext context) async {
    final turkish = TurkishLocale().model.locale;
    final english = EnglishLocale().model.locale;

    if (currentAdapter is TurkishLocale) {
      await context.setLocale(english).then((value) {
        currentAdapter = EnglishLocale() as LocaleAdapter;
        log('changed locale to  English ');
      });
    } else if (currentAdapter is EnglishLocale) {
      await context.setLocale(turkish).then((value) {
        currentAdapter = TurkishLocale() as LocaleAdapter;
        log('changed locale to  Turkish ');
      });
    }
  }
}

class NotificationSetting<NotificationAdapter>
    extends ISettings<NotificationAdapter> {
  LocalNotificationManager notificationManager;
  LocalManager localManager;

  NotificationSetting({
    required super.currentAdapter,
    required this.notificationManager,
    required this.localManager,
  });

  @override
  Future<void> changeState(BuildContext context) async {
    final toastManager = ToastManager(context: context);

    if (currentAdapter is ActivetedNotifications) {
      await notificationManager.cancelAllAlerts().then((value) async {
        log('Cancelled all alerts');

        currentAdapter = DeactivatedNotifications() as NotificationAdapter;

        await localManager.setAlertPermission(value: false);

        toastManager.showErrorToastMessage(
            text: LocaleKeys.toast_messages_notification_deactivated.tr());
      });
    } else if (currentAdapter is DeactivatedNotifications) {
      await notificationManager.setAlerts().then((value) async {
        log('Setted all alerts');

        currentAdapter = ActivetedNotifications() as NotificationAdapter;

        await localManager.setAlertPermission(value: true);

        toastManager.showSuccessToastMessage(
            text: LocaleKeys.toast_messages_notification_activated.tr());
      });
    }
  }

  Future<void> cancelAllAlertsAndSetAlerts() async {
    if (currentAdapter is ActivetedNotifications) {
      await notificationManager.cancelAllAlerts().whenComplete(
        () {
          log('Cancelled all alerts');
          return notificationManager.setAlerts().whenComplete(
                () => log('Setted all alerts'),
              );
        },
      );
    } else if (currentAdapter is DeactivatedNotifications) {
      log('dont setted any alert');
      return;
    }
  }
}
