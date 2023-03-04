import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/router/app_router.dart';
import '../../../init/lang/locale_keys.g.dart';
import '../../../theme/colors_tones.dart';
import '../../button/custom_text_button.dart';
import '../dialog_interface.dart';

class YesNoDialog extends IDialog {
  const YesNoDialog({
    super.key,
    required this.onPressedYes,
    required this.contentText,
    required this.headerText,
  });

  final void Function() onPressedYes;

  final String headerText;
  final String contentText;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
        titlePadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
        contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextButton(
            width: 35.w,
            onPressed: onPressedYes,
            text: LocaleKeys.game_yes_no_dialog_yes.tr(),
            backgroundColor: ColorsTones2.fail,
            fontSize: 40,
          ),
          CustomTextButton(
            width: 35.w,
            onPressed: () async {
              await router.pop();
            },
            text: LocaleKeys.game_yes_no_dialog_no.tr(),
            backgroundColor: ColorsTones2.success,
          ),
        ],
      )
    ];
  }

  Container _content() {
    return Container(
      height: 15.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.h),
      child: Center(
        child: AutoSizeText(
          contentText,
          textAlign: TextAlign.center,
          maxLines: 3,
          style: TextStyle(fontSize: 25, color: ColorsTones2.black),
        ),
      ),
    );
  }

  Container _title() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorsTones2.fail,
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
          color: ColorsTones2.azure2,
        ),
      ),
    );
  }

  @override
  Future<T?> show<T>(BuildContext context, {bool isDissmissible = false}) {
    return super.show(context, isDissmissible: isDissmissible);
  }
}
