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
      primaryColor: ColorsTones2.primaryColor,
      scaffoldBackgroundColor: ColorsTones2.primaryColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: ColorsTones2.azure,
          fontSize: 20,
        ),
        labelMedium: TextStyle(
          color: ColorsTones2.azure,
          fontSize: 20,
        ),
      ),
    );
  }

  static ThemeData get _darkTheme => ThemeData();

  static NeumorphicStyle _neumorphicStyle() {
    return NeumorphicStyle(
      color: ColorsTones2.secondaryColor,
      shadowLightColor: ColorsTones2.secondaryColor,
      shadowDarkColor: Colors.black,
      depth: 1,
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(12),
      ),
      border: NeumorphicBorder(
        color: ColorsTones2.secondaryColor,
        width: 1,
      ),
    );
  }

  // static final textButtonThemeData = TextButtonThemeData(
  //   style: ButtonStyle(
  //     backgroundColor: MaterialStatePropertyAll(ColorsTones2.secondaryColor),
  //     textStyle: MaterialStatePropertyAll(
  //       TextStyle(
  //         color: ColorsTones2.azure,
  //         fontSize: 20,
  //         fontFamily: ApplicationConstants.FONT_FAMILY_CONTENT,
  //       ),
  //     ),
  //     shape: MaterialStatePropertyAll(
  //       RoundedRectangleBorder(
  //         side: BorderSide(
  //           color: ColorsTones2.secondaryColor,
  //           width: 1.5,
  //         ),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //     ),
  //   ),
  // );
}
