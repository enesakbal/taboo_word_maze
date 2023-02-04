// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors_tones.dart';

class CustomElevatedButton extends StatefulWidget {
  final void Function() onPressed;

  final String text;

  final int maxLines;

  final double? height;
  final double? width;
  final double? fontSize;
  final double? elevation;
  final double borderRadius;
  final double borderWidth;

  final bool? hasAnimation;

  final Color? overlayColor;
  final Color? backgroundColor;
  final Color borderSideColor;

  final Color? firstAnimationColor;
  final Color? secondAnimationColor;

  const CustomElevatedButton({
    required this.onPressed,
    required this.text,
    this.maxLines = 1,
    this.height,
    this.width,
    this.fontSize = 25,
    this.borderRadius = 10,
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
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton>
    with AnimationMixin {
  late AnimationController colorController;
  late Animation<Color?> color;

  @override
  void initState() {
    colorController = createController()
      ..repeat(
        period: Duration(seconds: 1, milliseconds: 0),
        reverse: true,
      );

    color = ColorTween(
      begin: widget.firstAnimationColor ?? ColorTones.lightBlue,
      end: widget.secondAnimationColor ?? ColorTones.azure.withOpacity(1),
    ).animate(colorController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(seconds: 1, milliseconds: 0),
        width: widget.width ?? 100.w,
        height: widget.height ?? 5.h,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.gamepad,
                  color: Colors.black,
                ),
                Expanded(
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
                ),
              ],
            ),
          ),
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(widget.elevation),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor: MaterialStatePropertyAll(
                widget.hasAnimation! ? color.value : widget.backgroundColor),
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
}

