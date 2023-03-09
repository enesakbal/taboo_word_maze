import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/router/app_router.dart';
import '../../../theme/colors_tones.dart';
import '../../button/custom_text_button.dart';
import '../dialog_interface.dart';

class GameInfoDialog extends IDialog {
  const GameInfoDialog({
    super.key,
    required this.onPressed,
    required this.headerText,
    required this.contentText,
    required this.buttonText,
  });

  final void Function() onPressed;

  final String headerText;
  final String contentText;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onPressed.call();

        return true;
      },
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
        titlePadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
        contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 2.h),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.only(bottom: 2.h),
        iconPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        backgroundColor: ColorsTones.lightSkyBlue,
        iconColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        title: _title(),
        content: _content(),
        actions: _actions(),
      ),
    );
  }

  List<Widget> _actions() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextButton(
            width: 35.w,
            height: 6.h,
            onPressed: () async {
              await router.pop();
            },
            text: buttonText,
            backgroundColor: ColorsTones.success,
          ),
        ],
      )
    ];
  }

  Container _content() {
    return Container(
      height: 20.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.h),
      child: Center(
        child: AutoSizeText(
          contentText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: ColorsTones.black,
          ),
        ),
      ),
    );
  }

  Container _title() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorsTones.softBlue,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      alignment: Alignment.topCenter,
      child: Text(
        headerText,
        style: TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.bold,
          color: ColorsTones.azure,
        ),
      ),
    );
  }

  @override
  Future<T?> show<T>(BuildContext context, {bool isDissmissible = false}) {
    return super.show(context, isDissmissible: isDissmissible);
  }
}
