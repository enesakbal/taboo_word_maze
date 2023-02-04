import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../theme/colors_tones.dart';

class StorekedText extends StatelessWidget {
  final String text;

  final Color? strokeColor;
  final Color? textColor;

  final double? strokeWidth;
  final double? fontSize;

  final int? maxLines;

  final TextAlign? textAlign;

  const StorekedText({
    super.key,
    required this.text,
    this.strokeColor,
    this.textColor,
    this.strokeWidth,
    this.fontSize,
    this.maxLines,
    this.textAlign,
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
            fontSize: fontSize ?? 20,
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
            fontSize: fontSize ?? 20,
            color: textColor ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
