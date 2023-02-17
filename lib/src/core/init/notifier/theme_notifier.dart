import 'package:flutter/material.dart';

import '../../theme/adapter/theme_adapter.dart';

class ThemeModeNotifier extends ChangeNotifier {
  ThemeAdapter currentThemeAdapter;
  final Future<void> Function() saveChanges;
  ThemeModeNotifier(this.currentThemeAdapter,this.saveChanges);

  Future<void> changeTheme() async {
    if (currentThemeAdapter.model.themeMode == ThemeMode.light) {
      currentThemeAdapter = DarkTheme();
    } else {
      currentThemeAdapter = LightTheme();
    }
    await saveChanges();
    
    notifyListeners();
  }
}
