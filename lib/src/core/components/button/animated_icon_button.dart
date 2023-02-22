import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';

class SettingIconButton extends StatefulWidget {
  final IconData? icon;

  final Color? color;

  final String? svgData;

  final void Function()? onPressed;

  final double buttonSize;

  final Widget child;
  const SettingIconButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.color,
    this.svgData,
    this.buttonSize = 0.75,
  });

  @override
  State<SettingIconButton> createState() => _SettingIconButtonState();
}

class _SettingIconButtonState extends State<SettingIconButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.sp + widget.buttonSize * 2.h,
      width: 25.sp + widget.buttonSize * 2.h,
      child: NeumorphicButton(
        onPressed: widget.onPressed,
        padding:
            widget.svgData != null ? EdgeInsets.zero : EdgeInsets.all(widget.buttonSize.h),
        margin: EdgeInsets.zero,
        style: AppTheme.neumorphicStyle.copyWith(
          color: widget.color,
          shape: NeumorphicShape.convex,
          disableDepth: false,
        ),
        child: widget.child,
      ),
    );
  }
}
