import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../constants/app_constants.dart';
import 'colors_tones.dart';

class AppTheme {
  static ThemeData get theme => _theme;

  static ThemeData get darkTheme => _darkTheme;

  static NeumorphicStyle get neumorphicStyle => _neumorphicStyle();

  static ThemeData get _darkTheme => ThemeData(
        fontFamily: ApplicationConstants.FONT_FAMILY,
        primaryColor: ColorsTones.dark,
        scaffoldBackgroundColor: ColorsTones.dark,
        elevatedButtonTheme: _elevatedButtonStyle(),
        textButtonTheme: _textButtonStyle(),
        brightness: Brightness.dark,
        iconTheme: const IconThemeData(color: Colors.black),
      );

  static ThemeData get _theme => ThemeData(
        fontFamily: ApplicationConstants.FONT_FAMILY,
        primaryColor: ColorsTones.softBlue,
        scaffoldBackgroundColor: ColorsTones.softBlue,
        elevatedButtonTheme: _elevatedButtonStyle(),
        textButtonTheme: _textButtonStyle(),
        brightness: Brightness.light,
        iconTheme: const IconThemeData(color: Colors.black),
      );

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
