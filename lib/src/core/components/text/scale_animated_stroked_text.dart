// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../theme/colors_tones.dart';

class ScaleAnimatedStorekedText extends StatefulWidget {
  final String text;

  final Color? strokeColor;
  final Color? textColor;

  final double? strokeWidth;
  final double? fontSize;

  final int? maxLines;

  final TextAlign? textAlign;

  final FontWeight? fontWeight;

  const ScaleAnimatedStorekedText({
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
  State<ScaleAnimatedStorekedText> createState() =>
      _ScaleAnimatedStorekedTextState();
}

class _ScaleAnimatedStorekedTextState extends State<ScaleAnimatedStorekedText>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 2), value: 1)
      ..repeat(reverse: true, min: 0.80, max: 1);

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    //Curves.bounceOut

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Stack(
        children: <Widget>[
          AutoSizeText(
            widget.text,
            maxLines: widget.maxLines ?? 1,
            textAlign: widget.textAlign,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: widget.fontSize ?? 20,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              fontFamily: ApplicationConstants.FONT_FAMILY,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = widget.strokeWidth ?? 3
                ..color = widget.strokeColor ?? ColorsTones.softBlue,
            ),
          ),
          AutoSizeText(
            widget.text,
            maxLines: widget.maxLines ?? 1,
            textAlign: widget.textAlign,
            style: TextStyle(
              fontFamily: ApplicationConstants.FONT_FAMILY,
              decoration: TextDecoration.none,
              fontSize: widget.fontSize ?? 20,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              color: widget.textColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
