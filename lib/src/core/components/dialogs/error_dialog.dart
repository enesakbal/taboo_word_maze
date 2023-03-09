import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../../../config/router/app_router.dart';
import '../../rive/rive_constants.dart';
import '../../theme/colors_tones.dart';
import '../button/custom_text_button.dart';
import 'dialog_interface.dart';

class ErrorDialog extends IDialog {
  final String text;
  final String buttonText;
  final void Function()? onPressed;
  const ErrorDialog({
    super.key,
    required this.text,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
        titlePadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
        contentPadding: EdgeInsets.only(bottom: 0.h, left: 0.w, right: 0.w),
        backgroundColor: ColorsTones.lightSkyBlue,
        actionsPadding: EdgeInsets.only(bottom: 0.h),
        iconPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        iconColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        title: Align(
          alignment: Alignment.center,
          child: Container(
            width: 20.h,
            height: 15.h,
            // color: Colors.black,
            alignment: Alignment.topCenter,
            child: const RiveAnimation.asset(
              RiveConstants.errorAnimationPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        content: Container(
          width: 80.w,
          height: 18.h,
          // color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: AutoSizeText(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
              CustomTextButton(
                onPressed: () async {
                  await router.pop();
                  (onPressed ?? () {}).call();
                },
                text: buttonText,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<T?> show<T>(BuildContext context, {bool isDissmissible = false}) {
    return super.show(context, isDissmissible: isDissmissible);
  }
}
