import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';

class CustomTextButton extends StatelessWidget {
  final void Function() onPressed;

  final String text;

  final int? maxLines;

  final double? height;
  final double? width;
  final double? fontSize;
  final double? elevation;
  final double borderRadius;
  final double borderWidth;

  final Color? backgroundColor;
  final Color? borderSideColor;
  final Color? shadowLightColor;

  final FontWeight? fontWeight;

  final bool isEnabled;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.maxLines = 1,
    this.height,
    this.width,
    this.fontSize,
    this.borderRadius = 12,
    this.borderWidth = 1.5,
    this.elevation = 2,
    this.backgroundColor,
    this.borderSideColor = Colors.transparent,
    this.shadowLightColor = Colors.transparent,
    this.fontWeight,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 100.w,
      height: height ?? 5.h,
      child: NeumorphicButton(
        onPressed: onPressed,
        child: Center(
          child: AutoSizeText(
            text,
            maxLines: maxLines,
            style: TextStyle(
              fontSize: fontSize ?? 25,
              fontWeight: fontWeight ?? FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        style: isEnabled
            ? AppTheme.neumorphicStyle.copyWith(
                color: backgroundColor,
                border: NeumorphicBorder(
                  color: borderSideColor,
                  width: borderWidth,
                ),
                shadowLightColor: shadowLightColor,
              )
            : NeumorphicStyle(
                // border: NeumorphicBorder(
                //   color: borderSideColor,
                //   width: borderWidth,
                // ),
                color: Colors.black45,
                shadowLightColor: shadowLightColor,
                depth: 0,
                disableDepth: false,
                intensity: 0,
              ),
      ),
    );
  }
}
