
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/router/app_router.dart';
import '../../../init/lang/locale_keys.g.dart';
import '../../../theme/colors_tones.dart';
import '../../button/custom_text_button.dart';

extension Show on YesNoDialog {
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

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    super.key,
    required this.onPressedYes,
    required this.onPressedNo,
  });

  final void Function() onPressedYes;
  final void Function() onPressedNo;

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
            text: LocaleKeys.home_yes_no_dialog_yes.tr(),
            backgroundColor: ColorsTones2.fail,
            fontSize: 40,
          ),
          CustomTextButton(
            width: 35.w,
            onPressed: () async {
              await router.pop();
              onPressedNo.call();
            },
            text: LocaleKeys.home_yes_no_dialog_no.tr(),
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
          LocaleKeys.home_yes_no_dialog_content.tr(),
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
        LocaleKeys.home_yes_no_dialog_header.tr(),
        style: TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.bold,
          color: ColorsTones2.azure2,
        ),
      ),
    );
  }
}