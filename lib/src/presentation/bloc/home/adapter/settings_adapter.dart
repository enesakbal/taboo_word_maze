import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/toast/toast_manager.dart';
import '../../../../core/init/cache/local_manager.dart';

import '../../../../core/init/lang/adapter/language_adapter.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/notifications/fcm/push_notification_handler.dart';
import '../../../../core/init/notifications/local/adapter/notification_adapter.dart';
import '../../../../core/init/notifications/local/local_notification_manager.dart';
import '../../../../core/init/notifier/theme_notifier.dart';
import '../../../../core/theme/adapter/theme_adapter.dart';
import '../../../../domain/usecaces/firebase_document_usecase.dart';

abstract class ISettings<T> {
  T currentAdapter;

  Future<void> changeState(BuildContext context);

  ISettings({
    required this.currentAdapter,
  });
}

class ThemeSetting<T extends ThemeAdapter> extends ISettings<ThemeAdapter> {
  ThemeSetting({
    required super.currentAdapter,
  });

  @override
  Future<void> changeState(BuildContext context) async {
    final toastManager = ToastManager(context: context);

    toastManager.showInfoToastMessage(
        text: LocaleKeys.toast_messages_soon.tr());
    return;
    //?
    // final provider = Provider.of<ThemeModeNotifier>(context, listen: false);

    // await provider.changeTheme().then((value) {
    //   currentAdapter = provider.currentThemeAdapter;
    //   if (currentAdapter is LightTheme) {
    //     log('Changed theme to LightTheme');
    //   } else if (currentAdapter is DarkTheme) {
    //     log('Changed theme to DarkTheme');
    //   }
    // });
    //?
  }
}

class LangSetting<T extends LocaleAdapter> extends ISettings<LocaleAdapter> {
  LangSetting({required super.currentAdapter});

  @override
  Future<void> changeState(BuildContext context) async {
    final turkish = TurkishLocale().model.locale;
    final english = EnglishLocale().model.locale;

    if (currentAdapter is TurkishLocale) {
      await context.setLocale(english).then((value) {
        currentAdapter = EnglishLocale();
        log('Changed locale to English ');
      });
    } else if (currentAdapter is EnglishLocale) {
      await context.setLocale(turkish).then((value) {
        currentAdapter = TurkishLocale();
        log('Changed locale to Turkish ');
      });
    }
  }
}

class NotificationSetting<T extends NotificationAdapter>
    extends ISettings<NotificationAdapter> {
  LocalNotificationManager notificationManager;
  LocalManager localManager;
  PushNotificationHandler notificationHandler;
  FirebaseDocumentUsecase firebaseDocumentUsecase;

  NotificationSetting({
    required super.currentAdapter,
    required this.notificationManager,
    required this.localManager,
    required this.notificationHandler,
    required this.firebaseDocumentUsecase,
  });

  @override
  Future<void> changeState(BuildContext context) async {
    final toastManager = ToastManager(context: context);

    if (currentAdapter is ActivetedNotifications) {
      await notificationManager.cancelAllAlerts().then((value) async {
        currentAdapter = DeactivatedNotifications();
        /** Set current state with adapter */

        await localManager.setAlertPermission(value: false);
        /** set alert permission to false */

        toastManager.showErrorToastMessage(
            text: LocaleKeys.toast_messages_notification_deactivated.tr());
        /** show toast message */
      }).whenComplete(() {
        firebaseDocumentUsecase.declineNotifications();
        //* fire and forgot
      });

      log('Cancelled all local alerts');
    } else if (currentAdapter is DeactivatedNotifications) {
      await notificationManager.setAlerts().then((value) async {
        log('Setted all local alerts');

        currentAdapter = ActivetedNotifications();
        /** Set current state with adapter */

        await localManager.setAlertPermission(value: true);
        /** set alert permission to true */

        toastManager.showSuccessToastMessage(
            text: LocaleKeys.toast_messages_notification_activated.tr());
        /** show toast message */
      }).whenComplete(() {
        firebaseDocumentUsecase.allowNotifications();
        //* fire and forgot
      });
    }

    await notificationHandler.initialize();
    /** reinitialize */
  }

  Future<void> cancelAllAlertsAndSetAlerts() async {
    if (currentAdapter is ActivetedNotifications) {
      await notificationManager.cancelAllAlerts().whenComplete(
        () {
          log('Cancelled all local alerts');
          return notificationManager.setAlerts().whenComplete(
                () => log('Setted all local alerts'),
              );
        },
      );
    } else if (currentAdapter is DeactivatedNotifications) {
      log('Dont setted any local alert');
      return;
    }
  }
}
