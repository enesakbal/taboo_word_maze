import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors_tones.dart';

class CustomTextButton extends StatefulWidget {
  final void Function() onPressed;

  final String text;

  final int maxLines;

  final double? height;
  final double? width;
  final double? fontSize;
  final double? elevation;
  final double borderRadius;
  final double borderWidth;

  final bool hasAnimation;

  final Color? overlayColor;
  final Color? backgroundColor;
  final Color borderSideColor;

  final Color? firstAnimationColor;
  final Color? secondAnimationColor;

  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.maxLines = 1,
    this.height,
    this.width,
    this.fontSize = 25,
    this.borderRadius = 12,
    this.borderWidth = 1.5,
    this.hasAnimation = false,
    this.elevation = 2,
    this.overlayColor,
    this.backgroundColor,
    this.borderSideColor = Colors.black,
    this.firstAnimationColor,
    this.secondAnimationColor,
    super.key,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    //* start of color animation
    _colorController = AnimationController(vsync: this)
      ..repeat(
        period: const Duration(seconds: 1, milliseconds: 0),
        reverse: true,
      );

    _colorAnimation = ColorTween(
      begin: widget.firstAnimationColor ?? ColorsTones.lightBlue,
      end: widget.secondAnimationColor ?? ColorsTones.azure.withOpacity(1),
    ).animate(_colorController);

    //* end of color animation

    //**************************/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(seconds: 1, milliseconds: 0),
        width: widget.width ?? 100.w,
        height: widget.height ?? 5.h,
        child: TextButton(
          onPressed: widget.onPressed,
          child: Center(
            child: AutoSizeText(
              widget.text,
              maxLines: widget.maxLines,
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(widget.elevation),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 5.w),
            ),
            backgroundColor: MaterialStatePropertyAll(widget.hasAnimation
                ? _colorAnimation.value
                : widget.backgroundColor),
            overlayColor: MaterialStatePropertyAll(widget.overlayColor),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: widget.borderSideColor,
                  width: widget.borderWidth,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    if (widget.hasAnimation == true) {
      _colorController.dispose();
    }
    super.dispose();
  }
}
