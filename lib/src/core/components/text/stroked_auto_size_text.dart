import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../theme/colors_tones.dart';

class StorekedAutoSizeText extends StatelessWidget {
  final String text;

  final Color? strokeColor;
  final Color? textColor;

  final double? strokeWidth;
  final double? fontSize;

  final int? maxLines;

  final TextAlign? textAlign;

  final FontWeight? fontWeight;

  const StorekedAutoSizeText({
    super.key,
    required this.text,
    this.strokeColor,
    this.textColor,
    this.strokeWidth,
    this.fontSize,
    this.maxLines,
    this.textAlign,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AutoSizeText(
          text,
          maxLines: maxLines ?? 1,
          textAlign: textAlign,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: ApplicationConstants.FONT_FAMILY,
            fontSize: fontSize ?? 20,
            fontWeight: fontWeight ?? FontWeight.normal,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth ?? 3
              ..color = strokeColor ?? ColorTones.softBlue,
          ),
        ),
        AutoSizeText(
          text,
          maxLines: maxLines ?? 1,
          textAlign: textAlign,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: ApplicationConstants.FONT_FAMILY,
            fontSize: fontSize ?? 20,
            fontWeight: fontWeight ?? FontWeight.normal,
            color: textColor ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
