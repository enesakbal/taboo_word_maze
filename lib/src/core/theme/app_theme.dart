import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import 'colors_tones.dart';

class AppTheme {
  static ThemeData get theme => _theme;

  static ThemeData get _theme => ThemeData(
        fontFamily: ApplicationConstants.FONT_FAMILY,
        primaryColor: ColorTones.lightBlue,
      );
}
