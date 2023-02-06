import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/components/button/custom_button.dart';
import '../../core/components/text/scale_animated_stroked_text.dart';
import '../../core/components/text/stroked_auto_size_text.dart';
import '../../core/components/text/stroked_text.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 7.5.h),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _headers(),
            SizedBox(height: 5.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _playButton(),
                SizedBox(height: 5.h),
                _editButton(),
                SizedBox(height: 5.h),
                // _settingsButton(),
                // SizedBox(height: 5.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _headers() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'header-1',
              child: StorekedText(
                textAlign: TextAlign.center,
                text: LocaleKeys.splash_title.tr(),
                strokeColor: Colors.black,
                strokeWidth: 4,
                fontSize: 60,
              ),
            ),
          ),
          Center(
            child: Hero(
              tag: 'header-2',
              child: StorekedText(
                textAlign: TextAlign.center,
                text: LocaleKeys.splash_subtitle.tr(),
                strokeColor: Colors.black,
                strokeWidth: 4,
                fontSize: 45,
              ),
            ),
          ),
        ],
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

  Widget _notificationButton() {
    return Container();
    //TODO buraya 3 adet icon button koy, derinlik koyarak çalış
    //todo birincisi bildirimleri açıp kapatsın buna uygun iki adet icon koy
    //todo ikincisi dartk theme geçişi olsun
    //todo üçünücüsü iki adet bayrak kullan ve bu butona tıklanıldığında dili değiştir

    //todo dördüncüsü rate me butonu olsun hem icon hem yazı tutan bir widget yaz
  }
}
