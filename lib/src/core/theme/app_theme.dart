import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../constants/app_constants.dart';
import 'colors_tones.dart';

class AppTheme {
  static ThemeData get theme => _theme;

  static ThemeData get darkTheme => _darkTheme;

  static NeumorphicStyle get neumorphicStyle => _neumorphicStyle();

  static ThemeData get _theme {
    return ThemeData(
      fontFamily: ApplicationConstants.FONT_FAMILY_CONTENT,
      primaryColor: ColorsTones.primaryColor,
      scaffoldBackgroundColor: ColorsTones.primaryColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: ColorsTones.azure,
          fontSize: 20,
        ),
        labelMedium: TextStyle(
          color: ColorsTones.azure,
          fontSize: 20,
        ),
      ),
    );
  }

  static ThemeData get _darkTheme => ThemeData();

  static NeumorphicStyle _neumorphicStyle() {
    return NeumorphicStyle(
      color: ColorsTones.secondaryColor,
      shadowLightColor: ColorsTones.secondaryColor,
      shadowDarkColor: Colors.black,
      depth: 1,
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(12),
      ),
      border: NeumorphicBorder(
        color: ColorsTones.secondaryColor,
        width: 1,
      ),
    );
  }
}
