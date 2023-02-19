import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors_tones.dart';

class AnimatedIconButton extends StatelessWidget {
  final IconData? icon;

  final Color? color;

  final String? svgData;

  final void Function()? onPressed;

  final double buttonSize;

  final Widget child;
  const AnimatedIconButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.color,
    this.svgData,
    this.buttonSize = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.sp + buttonSize * 2.h,
      width: 25.sp + buttonSize * 2.h,
      child: NeumorphicButton(
        onPressed: onPressed,
        padding:
            svgData != null ? EdgeInsets.zero : EdgeInsets.all(buttonSize.h),
        margin: EdgeInsets.zero,
        style: AppTheme.neumorphicStyle.copyWith(
          color: color,
          shape: NeumorphicShape.convex,
          disableDepth: false,
        ),
        child: child,
      ),
    );
  }
}
