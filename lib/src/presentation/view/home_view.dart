// ignore_for_file: prefer_const_constructors, unused_field, strict_raw_type

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../config/router/app_router.dart';
import '../../core/components/button/custom_icon_button.dart';
import '../../core/components/button/custom_text_button.dart';
import '../../core/components/dialogs/start_game_dialog/start_game_dialog.dart';
import '../../core/components/text/stroked_auto_size_text.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/theme/colors_tones.dart';
import '../bloc/home/home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeBloc>().add(const ClearAlertsAndSetAgain());

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
          resizeToAvoidBottomInset: false,
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
      decoration: BoxDecoration(shape: BoxShape.circle),
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
    return StorekedAutoSizeText(
      text: LocaleKeys.splash_title.tr(),
      fontSize: 85,
      fontWeight: FontWeight.w900,
      strokeColor: ColorsTones2.secondaryColor,
      strokeWidth: 6,
    );
  }

  Widget _playButton() {
    return CustomTextButton(
      onPressed: () async {
        await StartGameDialog().show(context);
      },
      text: LocaleKeys.home_play.tr(),
      height: 7.5.h,
      width: 60.w,
    );
  }

  Widget _editButton() {
    return CustomTextButton(
      onPressed: () async => router.push(const EditRoute()),
      text: LocaleKeys.home_edit.tr(),
      height: 7.5.h,
      width: 60.w,
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return CustomIconButton(
          onPressed: () async {
            context.read<HomeBloc>().add(ChangeNotification(context));
          },
          icon: state.notificationAdapter.model.iconData, //on
        );
      },
    );
  }

  Widget _themeButton() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return CustomIconButton(
          onPressed: () async {
            context.read<HomeBloc>().add(ChangeTheme(context));
          },
          icon: state.themeAdapter.model.iconData,
        ); //on
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
