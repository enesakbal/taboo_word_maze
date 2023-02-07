import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enums/preferences_enums.dart';
import '../notifications/adapter/notification_adapter.dart';
import '../theme/adapter/theme_adapter.dart';

class LocalManager {
  final SharedPreferences preferences;

  const LocalManager({required this.preferences});

  ThemeAdapter getCurrentThemeMode() {
    final isDark = preferences.getBool(PreferencesKeys.THEME.name);
    if (isDark == null) {
      final brightness = SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark;
      if (brightness) {
        return DarkTheme();
      }
      return LightTheme();
    } else {
      if (isDark) {
        return DarkTheme();
      }
      return LightTheme();
    }
  }

  Future<void> changeThemeMode() async {
    final current = getCurrentThemeMode();
    if (current.model.themeMode == ThemeMode.dark) {
      await preferences.setBool(PreferencesKeys.THEME.name, false);
    } else {
      await preferences.setBool(PreferencesKeys.THEME.name, true);
    }
  }

  Future<void> setAlertPermission({required bool value}) {
    return preferences.setBool(
        PreferencesKeys.NOTIFICATION_STATUS.toString(), value);
  }

  NotificationAdapter getCurrentAlertAdapter() {
    final permission =
        preferences.getBool(PreferencesKeys.NOTIFICATION_STATUS.toString());
    if (permission == null) {
      return DeactivetedNotifications();
    }
    if (permission) {
      return ActivetedNotifications();
    } else {
      return DeactivetedNotifications();
    }
  }

  Future<bool> clearAllValues() async => preferences.clear();
}
