import 'package:flutter/material.dart';

class ThemeModeNotifier extends ChangeNotifier {
  ThemeMode currentTheme;
  final Future<void> Function() saveChanges;
  ThemeModeNotifier(this.currentTheme,this.saveChanges);

  Future<void> changeTheme() async {
    if (currentTheme == ThemeMode.light) {
      currentTheme = ThemeMode.dark;
    } else {
      currentTheme = ThemeMode.light;
    }
    await saveChanges();
    
    notifyListeners();
  }
}
