import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

import 'package:sizer/sizer.dart';

import '../../../presentation/bloc/home/adapter/settings_adapter.dart';
import '../../theme/adapter/theme_adapter.dart';
import '../../theme/colors_tones.dart';

class ToastManager {
  final BuildContext context;

  late FToast fToast;
  late bool isDarkTheme;

  ToastManager({
    required this.context,
  }) {
    fToast = FToast();
    fToast.init(context);
    isDarkTheme =
        GetIt.I<ThemeSetting<ThemeAdapter>>().currentAdapter is DarkTheme;
  }

  void showSuccessToastMessage({
    required String text,
  }) {
    fToast.showToast(
      child: Container(
        width: 60.w,
        height: 5.h,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isDarkTheme ? Colors.grey : Colors.greenAccent,
        ),
        child: Row(
          children: [
            Container(
              height: 5.h,
              width: 10.w,
              child: const Icon(
                Icons.check_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
            Container(
              height: 5.h,
              width: 40.w,
              alignment: Alignment.center,
              child: AutoSizeText(
                text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showInfoToastMessage({
    required String text,
  }) {
    fToast.showToast(
      child: Container(
        width: 60.w,
        height: 5.h,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: ColorsTones.pass,
        ),
        child: Container(
          height: 5.h,
          width: 40.w,
          alignment: Alignment.center,
          child: AutoSizeText(
            text,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void showErrorToastMessage({
    required String text,
  }) {
    fToast.showToast(
      child: Container(
        width: 60.w,
        height: 5.h,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: ColorsTones.fail,
        ),
        child: Row(
          children: [
            Container(
              height: 5.h,
              width: 10.w,
              child: Icon(
                Icons.close_outlined,
                size: 20,
                color: ColorsTones.azure,
              ),
            ),
            Container(
              height: 5.h,
              width: 40.w,
              alignment: Alignment.center,
              child: AutoSizeText(
                text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: ColorsTones.azure,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
