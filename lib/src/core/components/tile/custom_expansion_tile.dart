import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors_tones.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    Key? key,
    this.collapsedTextColor,
    required this.textColor,
    required this.expansionTitle,
    this.iconColorChanger = false,
    this.leading,
    this.children,
    this.subTitle,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.titleColor,
  }) : super(key: key);

  final Color? collapsedTextColor;
  final Color textColor;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final bool initiallyExpanded;
  final void Function(bool)? onExpansionChanged;

  final String expansionTitle;
  final bool iconColorChanger;
  final Text? leading;
  final Widget? subTitle;
  final Color? titleColor;

  final List<Widget>? children;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: widget.onExpansionChanged,
      tilePadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
      childrenPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: ColorsTones2.softBlue.withOpacity(0.6),
      collapsedBackgroundColor: ColorsTones2.pass,
      collapsedTextColor: widget.collapsedTextColor,
      textColor: widget.textColor,
      title: AutoSizeText(
        widget.expansionTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: widget.titleColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: widget.subTitle,
      children: widget.children!,
    );
  }
}
