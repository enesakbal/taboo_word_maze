import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors_tones.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.onChanged,
    this.hintText,
    this.enabledColor,
    this.focusedColor,
    this.fillColor,
    this.prefixIconColor,
    this.prefixIcon,
    this.suffixIconColor,
    this.suffixIcon,
  });

  final String? hintText;

  final TextEditingController controller;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  final Color? focusedColor;
  final Color? enabledColor;
  final Color? fillColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 10.h,
      child: Center(
        child: TextFormField(
          controller: controller,
          validator: validator,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          scrollPadding: EdgeInsets.zero,
          cursorColor: Colors.black,
          onChanged: onChanged,
          decoration: InputDecoration(
            fillColor: fillColor ?? Colors.black12,
            filled: true,
            hintText: hintText,
            contentPadding: const EdgeInsets.all(12),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: enabledColor ?? ColorsTones2.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusedColor ?? ColorsTones2.black,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            errorStyle: TextStyle(
              color: ColorsTones2.fail,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsTones2.fail,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsTones2.fail, width: 2.5),
            ),
            prefixIcon: prefixIcon,
            prefixIconColor: prefixIconColor,
            suffixIcon: suffixIcon,
            suffixIconColor: suffixIconColor,
          ),
        ),
      ),
    );
  }
}
