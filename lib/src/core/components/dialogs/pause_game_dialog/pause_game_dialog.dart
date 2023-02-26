import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/router/app_router.dart';
import '../../../init/lang/locale_keys.g.dart';
import '../../../theme/colors_tones.dart';
import '../../button/custom_text_button.dart';

extension Show on PauseGameDialog {
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

class PauseGameDialog extends StatelessWidget {
  const PauseGameDialog({
    super.key,
    required this.onPressedHome,
    required this.onPressedResume,
  });

  final void Function() onPressedHome;
  final void Function() onPressedResume;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextButton(
            width: 35.w,
            height: 6.h,
            onPressed: onPressedHome,
            text: LocaleKeys.home_pause_dialog_home_button.tr(),
            backgroundColor: ColorsTones2.pass,
          ),
          CustomTextButton(
            width: 35.w,
            height: 6.h,
            onPressed: () async {
              await router.pop();
              onPressedResume.call();
            },
            text: LocaleKeys.home_pause_dialog_resume_button.tr(),
            backgroundColor: ColorsTones2.success,
          ),
        ],
      )
    ];
  }

  Container _content() {
    return Container(
      height: 50.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.h),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 15.w,
                  // ignore: prefer_const_constructors
                  child: AutoSizeText(
                    'Round',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    LocaleKeys.home_play_dialog_team_1.tr(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    LocaleKeys.home_play_dialog_team_2.tr(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.5.h),
            Container(
              height: 35.h,
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 14,
                itemBuilder: (context, index) {
                  final num = Random().nextInt(15);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15.w,
                        child: Text(
                          index.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: AutoSizeText(
                          num.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: AutoSizeText(
                          index.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                SizedBox(
                  width: 15.w,
                  child: Text(
                    15.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    15.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    15.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _title() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorsTones2.softBlue,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      alignment: Alignment.topCenter,
      child: Text(
        LocaleKeys.home_pause_dialog_header.tr(),
        style: TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.bold,
          color: ColorsTones2.azure,
        ),
      ),
    );
  }
}
