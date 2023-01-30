// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../../lang/locale_keys.g.dart';
import '../../theme/colors_tones.dart';
import '../button/custom_button.dart';

class ErrorDialog extends StatefulWidget {
  const ErrorDialog({super.key});

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
        titlePadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
        contentPadding: EdgeInsets.only(bottom: 0.h, left: 0.w, right: 0.w),
        backgroundColor: ColorTones.lightSkyBlue,
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
            child: RiveAnimation.asset(
              'assets/animation/error.riv',
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
                  LocaleKeys.errors_no_data.tr(),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomElevatedButton()
            ],
          ),
        ),
      ),
    );
  }
}

extension Error on ErrorDialog {
  Future<T?> show<T>(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return this;
      },
    );
  }
}