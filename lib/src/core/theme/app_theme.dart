import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../constants/app_constants.dart';
import 'colors_tones.dart';

class AppTheme {
  static ThemeData get theme => _theme;

  static ThemeData get darkTheme => _darkTheme;

  static NeumorphicStyle get neumorphicStyle => _neumorphicStyle();

  static ThemeData get _theme => ThemeData(
        fontFamily: ApplicationConstants.FONT_FAMILY,
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.transparent),
        scaffoldBackgroundColor: ColorsTones.softBlue,
        elevatedButtonTheme: _elevatedButtonStyle(),
        textButtonTheme: _textButtonStyleLight(),
        brightness: Brightness.light,
        iconTheme: const IconThemeData(color: Colors.black),
      );

  static ThemeData get _darkTheme => ThemeData(
        fontFamily: ApplicationConstants.FONT_FAMILY,
        primaryColor: ColorsTones.darkPrimary,
        appBarTheme: AppBarTheme(color: Colors.transparent),
        scaffoldBackgroundColor: ColorsTones.darkSecondary,
        elevatedButtonTheme: _elevatedButtonStyle(),
        textButtonTheme: _textButtonStyleDark(),
        brightness: Brightness.dark,
        iconTheme: const IconThemeData(color: Colors.black),
      );

  static ElevatedButtonThemeData _elevatedButtonStyle() {
    return ElevatedButtonThemeData(
      style: IconButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: ColorsTones.buttonBackgroundColorLight,
        elevation: 12,
        padding: EdgeInsets.zero,
      ),
    );
  }

  static TextButtonThemeData _textButtonStyleLight() {
    return TextButtonThemeData(
      style: IconButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: ColorsTones.buttonBackgroundColorLight,
        elevation: 12,
        padding: EdgeInsets.zero,
        hoverColor: Colors.red,
      ),
    );
  }

  static TextButtonThemeData _textButtonStyleDark() {
    return TextButtonThemeData(
      style: IconButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: ColorsTones.buttonBackgroundColorDark,
        elevation: 12,
        padding: EdgeInsets.zero,
        hoverColor: Colors.red,
      ),
    );
  }

  static NeumorphicStyle _neumorphicStyle() {
    return NeumorphicStyle(
      color: ColorsTones.buttonBackgroundColorLight,
      shadowLightColor: ColorsTones.buttonBackgroundColorLight,
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
