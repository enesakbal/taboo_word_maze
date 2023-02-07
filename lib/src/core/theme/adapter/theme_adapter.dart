import 'package:flutter/material.dart';


abstract class ThemeAdapter {
  ThemeAdapterModel get model;
}

class ThemeAdapterModel {
  final IconData iconData;
  final ThemeMode themeMode;

  const ThemeAdapterModel({
    required this.iconData,
    required this.themeMode,
  });

  factory ThemeAdapterModel.light() => const ThemeAdapterModel(
        iconData: Icons.light_mode_outlined,
        themeMode: ThemeMode.light,
      );

  factory ThemeAdapterModel.dark() => const ThemeAdapterModel(
        iconData: Icons.dark_mode_outlined,
        themeMode: ThemeMode.dark,
      );
}

class LightTheme implements ThemeAdapter {
  @override
  ThemeAdapterModel get model => ThemeAdapterModel.light();
}

class DarkTheme implements ThemeAdapter {
  @override
  ThemeAdapterModel get model => ThemeAdapterModel.dark();
}
