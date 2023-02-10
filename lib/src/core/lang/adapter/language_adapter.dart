import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

abstract class LocaleAdapter {
  LocaleAdapterModel get model;
}

class LocaleAdapterModel {
  final String imagePath;
  final Locale locale;

  const LocaleAdapterModel({
    required this.imagePath,
    required this.locale,
  });

  factory LocaleAdapterModel.turkish() => const LocaleAdapterModel(
        imagePath: ApplicationConstants.TURKEY_SVG,
        locale: Locale('tr', 'TR'),
      );

  factory LocaleAdapterModel.english() => const LocaleAdapterModel(
        imagePath: ApplicationConstants.EU_SVG,
        locale: Locale('en', 'US'),
      );
}

class TurkishLocale implements LocaleAdapter {
  @override
  LocaleAdapterModel get model => LocaleAdapterModel.turkish();
}

class EnglishLocale implements LocaleAdapter {
  @override
  LocaleAdapterModel get model => LocaleAdapterModel.english();
}
