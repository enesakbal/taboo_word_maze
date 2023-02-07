import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

abstract class LocaleAdapter {
  DynamicLocaleModel get model;

}

class DynamicLocaleModel {
  final String imagePath;
  final Locale locale;

  const DynamicLocaleModel({
    required this.imagePath,
    required this.locale,
  });

  factory DynamicLocaleModel.turkish() => const DynamicLocaleModel(
        imagePath: ApplicationConstants.TURKEY_SVG,
        locale: Locale('tr', 'TR'),
      );

  factory DynamicLocaleModel.english() => const DynamicLocaleModel(
        imagePath: ApplicationConstants.EU_SVG,
        locale: Locale('en', 'US'),
      );
}

class TurkishLocale implements LocaleAdapter {
  @override
  DynamicLocaleModel get model => DynamicLocaleModel.turkish();

}
class EnglishLocale implements LocaleAdapter {
  @override
  DynamicLocaleModel get model => DynamicLocaleModel.english();

}
