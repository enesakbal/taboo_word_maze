import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enums/preferences_enums.dart';

class LocalManager {
  final SharedPreferences preferences;

  const LocalManager({required this.preferences});

  ThemeMode getCurrentThemeMode() {
    final isDark = preferences.getBool(PreferencesKeys.THEME.name);

    if (isDark == null) {
      final brightness = SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark;
      if (brightness) {
        return ThemeMode.dark;
      }
      return ThemeMode.light;
    } else {
      if (isDark) {
        return ThemeMode.dark;
      }
      return ThemeMode.light;
    }
  }

  Future<void> changeThemeMode() async {
    final current = getCurrentThemeMode();

    if (current == ThemeMode.dark) {
      await preferences.setBool(PreferencesKeys.THEME.name, false);
    } else {
      await preferences.setBool(PreferencesKeys.THEME.name, true);
    }

  }
}
