import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors_tones.dart';

class CustomIconButton extends StatelessWidget {
  final IconData? icon;

  final Color? color;
  final Color? shadowLightColor;

  final String? svgData;

  final NeumorphicBorder? border;

  final void Function()? onPressed;

  final double buttonSize;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.color,
    this.svgData,
    this.buttonSize = 0.75,
    this.shadowLightColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      padding: svgData != null ? EdgeInsets.zero : EdgeInsets.all(buttonSize.h),
      margin: EdgeInsets.zero,
      style: AppTheme.neumorphicStyle.copyWith(
        color: color,
        shape: NeumorphicShape.convex,
        disableDepth: false,
        shadowLightColor: shadowLightColor,
        border: border,
      ),
      child: svgData != null
          ? SvgPicture.asset(
              svgData!,
              fit: BoxFit.fill,
              height: 25.sp + buttonSize * 2.h,
              width: 25.sp + buttonSize * 2.h,
            )
          : Icon(
              icon,
              color: ColorsTones2.azure2,
              size: 25.sp,
            ),
    );
  }
}
