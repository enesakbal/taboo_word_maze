import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/components/button/custom_icon_button.dart';
import '../../core/components/button/custom_text_button.dart';
import '../../core/components/text/stroked_text.dart';
import '../../core/lang/locale_keys.g.dart';
import '../bloc/home/home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 7.5.h),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _headers(),
            SizedBox(height: 15.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _playButton(),
                SizedBox(height: 5.h),
                _editButton(),
                SizedBox(height: 3.h),
                _iconButtons()
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
                fontSize: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _playButton() {
    return CustomTextButton(
      onPressed: () {},
      text: LocaleKeys.home_play.tr(),
      height: 7.5.h,
      width: 55.w,
      hasAnimation: true,
    );
  }

  Widget _editButton() {
    return CustomTextButton(
      onPressed: () {},
      text: LocaleKeys.home_edit.tr(),
      height: 7.5.h,
      width: 55.w,
      hasAnimation: false,
    );
  }

  Widget _iconButtons() {
    return SizedBox(
      width: 55.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _notificationButton(),
          _themeButton(),
          _rateMeButton(),
          _langButton(),
        ],
      ),
    );
  }

  Widget _notificationButton() {
    return CustomIconButton(
      onPressed: () async {},
      icon: Icons.notifications_off_outlined, //on
    );
  }

  Widget _themeButton() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return CustomIconButton(
            onPressed: () async {
              context.read<HomeBloc>().add(ChangeTheme(context));
            },
            icon: state.themeAdapter.model.iconData //dark_mode
            );
      },
    );
  }

  Widget _rateMeButton() {
    return CustomIconButton(
      onPressed: () async {},
      icon: Icons.star_border_outlined,
    );
  }

  Widget _langButton() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return CustomIconButton(
          onPressed: () async {
            context.read<HomeBloc>().add(ChangeLocale(context));
          },
          svgData: state.localeAdapter.model.imagePath,
        );
      },
    );
  }
}
