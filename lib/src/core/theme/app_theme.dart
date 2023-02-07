import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../constants/app_constants.dart';
import 'colors_tones.dart';

class AppTheme {
  static ThemeData get theme => _theme;

  static NeumorphicStyle get neumorphicStyle => _neumorphicStyle();

  static ThemeData get _theme => ThemeData(
      fontFamily: ApplicationConstants.FONT_FAMILY,
      primaryColor: ColorsTones.lightBlue,
      elevatedButtonTheme: _elevatedButtonStyle(),
      textButtonTheme: _textButtonStyle());

  static ElevatedButtonThemeData _elevatedButtonStyle() {
    return ElevatedButtonThemeData(
      style: IconButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: ColorsTones.buttonBackgroundColor,
        elevation: 12,
        padding: EdgeInsets.zero,
      ),
    );
  }

  static TextButtonThemeData _textButtonStyle() {
    return TextButtonThemeData(
      style: IconButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: ColorsTones.buttonBackgroundColor,
        elevation: 12,
        padding: EdgeInsets.zero,
      ),
    );
  }

  static NeumorphicStyle _neumorphicStyle() {
    return NeumorphicStyle(
      color: ColorsTones.buttonBackgroundColor,
      shadowLightColor: ColorsTones.buttonBackgroundColor,
      shadowDarkColor: Colors.black,
      depth: 1,
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(12),
      ),
      border: const NeumorphicBorder(
        color: Colors.black,
        width: 1,
      ),
    );
  }
}
