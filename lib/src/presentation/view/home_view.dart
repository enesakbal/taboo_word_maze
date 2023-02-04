import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/components/button/custom_button.dart';
import '../../core/lang/locale_keys.g.dart';
import '../../core/theme/colors_tones.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: 100.h,
      width: 100.w,
      color: ColorTones.softBlue,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.5.h),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _playButton(),
            SizedBox(height: 5.h),
            _editButton(),
            SizedBox(height: 5.h),
            _settingsButton(),
            SizedBox(height: 5.h),
            _rateMeButton(),
          ],
        ),
      ),
    );
  }

  Widget _playButton() {
    return CustomElevatedButton(
      onPressed: () {},
      text: LocaleKeys.home_play.tr(),
      height: 7.5.h,
      width: 55.w,
      hasAnimation: true,
    );
  }

  Widget _editButton() {
    return CustomElevatedButton(
      onPressed: () {},
      text: LocaleKeys.home_edit.tr(),
      height: 7.5.h,
      width: 55.w,
      backgroundColor: ColorTones.azure.withOpacity(0.8),
      hasAnimation: false,
    );
  }

  Widget _settingsButton() {
    return CustomElevatedButton(
      onPressed: () {},
      text: LocaleKeys.home_settings.tr(),
      height: 7.5.h,
      width: 55.w,
      backgroundColor: ColorTones.azure.withOpacity(0.8),
    );
  }

  Widget _rateMeButton() {
    return CustomElevatedButton(
      onPressed: () {},
      text: LocaleKeys.home_rate.tr(),
      height: 7.5.h,
      width: 55.w,
      backgroundColor: ColorTones.azure.withOpacity(0.8),
      overlayColor: ColorTones.goldenYellow,
    );
  }
}
