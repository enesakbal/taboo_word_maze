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
  });

  final String? hintText;

  final TextEditingController controller;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

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
            fillColor: Colors.black12,
            hintText: hintText,
            contentPadding: const EdgeInsets.all(12),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
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
            // // fillColor: Colors.red.withOpacity(0.3),
            filled: true,
          ),
        ),
      ),
    );
  }
}
