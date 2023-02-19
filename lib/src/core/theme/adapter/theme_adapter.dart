import 'package:flutter/material.dart';


abstract class ThemeAdapter {
  ThemeAdapterModel get model;
}

class ThemeAdapterModel {
  final String animationState;
  final ThemeMode themeMode;

  const ThemeAdapterModel({
    required this.animationState,
    required this.themeMode,
  });

  factory ThemeAdapterModel.light() => const ThemeAdapterModel(
        animationState: 'day',
        themeMode: ThemeMode.light,
      );

  factory ThemeAdapterModel.dark() => const ThemeAdapterModel(
        animationState: 'night',
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
