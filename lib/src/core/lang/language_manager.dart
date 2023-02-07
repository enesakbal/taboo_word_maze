import 'package:flutter/material.dart';

import 'adapter/language_adapter.dart';

class LanguageManager {
  final enLocale = const Locale('en', 'US');
  final trLocale = const Locale('tr', 'TR');

  static Locale? currentLocale;

  static LocaleAdapter getAdapter() {
    if (currentLocale == const Locale('tr', 'TR')) {
      return TurkishLocale();
    } else {
      return EnglishLocale();
    }
  }

  static Locale? localeResolutionCallback(
      Locale? locale, Iterable<Locale> supportedLocales) {
    for (final element in supportedLocales) {
      if (element == locale!) {
        currentLocale = element;
        return element;
      }
    }
    currentLocale = supportedLocales.first;

    return supportedLocales.first;
  }

  List<Locale> get supportedLocales => [enLocale, trLocale];
}
