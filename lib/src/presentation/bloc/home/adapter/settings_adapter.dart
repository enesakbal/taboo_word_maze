import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../../core/cache/local_manager.dart';
import '../../../../core/lang/adapter/language_adapter.dart';
import '../../../../core/lang/language_manager.dart';
import '../../../../core/notifier/theme_notifier.dart';

abstract class SettingsAdapter<T> {
  T initialValue;

  Future<void> changeState(BuildContext context);

  SettingsAdapter({
    required this.initialValue,
  });
}

class ThemeSetting<ThemeAdapter> extends SettingsAdapter<ThemeAdapter> {
  ThemeAdapter currentAdapter = GetIt.I<LocalManager>().getCurrentThemeMode() as ThemeAdapter;

  ThemeSetting({
    required super.initialValue,
  });

  @override
  Future<void> changeState(BuildContext context) async {
    final provider = Provider.of<ThemeModeNotifier>(context, listen: false);

    await provider.changeTheme();
    currentAdapter = provider.currentThemeAdapter as ThemeAdapter;
  }
}

class LangSetting<LocaleAdapter> extends SettingsAdapter<LocaleAdapter> {
  LocaleAdapter currentAdapter =
      LanguageManager.getCurrentAdapter() as LocaleAdapter;

  LangSetting({required super.initialValue});

  @override
  Future<void> changeState(BuildContext context) async {
    final turkish = TurkishLocale().model.locale;
    final english = EnglishLocale().model.locale;

    if (context.locale == TurkishLocale().model.locale) {
      await context.setLocale(english);
      currentAdapter = EnglishLocale() as LocaleAdapter;
    } else {
      currentAdapter = TurkishLocale() as LocaleAdapter;
      await context.setLocale(turkish);
    }
  }
}

class NotificationSetting extends SettingsAdapter {
  NotificationSetting({required super.initialValue});

  @override
  Future<void> changeState(BuildContext context) {
    throw UnimplementedError();
  }
}
