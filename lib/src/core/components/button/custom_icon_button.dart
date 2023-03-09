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

  final Widget? badgeCounter;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.color,
    this.svgData,
    this.buttonSize = 0.75,
    this.shadowLightColor,
    this.border,
    this.badgeCounter,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NeumorphicButton(
          onPressed: onPressed,
          padding:
              svgData != null ? EdgeInsets.zero : EdgeInsets.all(buttonSize.h),
          margin:
              badgeCounter != null ? EdgeInsets.all(0.5.h) : EdgeInsets.zero,
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
                  height: 27.5.sp + buttonSize * 2.h,
                  width: 27.5.sp + buttonSize * 2.h,
                )
              : Icon(
                  icon,
                  color: ColorsTones.azure2,
                  size: 27.5.sp,
                ),
        ),
        if (badgeCounter != null)
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 5.w,
                height: 5.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsTones.azure,
                ),
                child: badgeCounter,
              )),
      ],
    );
  }
}
