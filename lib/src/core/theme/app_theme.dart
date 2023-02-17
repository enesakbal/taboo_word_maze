import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../constants/app_constants.dart';
import 'colors_tones.dart';

class AppTheme {
  static ThemeData get theme => _theme;

  static ThemeData get darkTheme => _darkTheme;

  static NeumorphicStyle get neumorphicStyle => _neumorphicStyle();

  static ThemeData get _theme => ThemeData(
        fontFamily: ApplicationConstants.FONT_FAMILY,
        primaryColor: ColorsTones2.primaryColor,
        scaffoldBackgroundColor: ColorsTones2.primaryColor,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: ColorsTones2.azure,
            fontSize: 20,
          ),
        ),
      );

  static ThemeData get _darkTheme => ThemeData(
        fontFamily: ApplicationConstants.FONT_FAMILY,
      );

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
