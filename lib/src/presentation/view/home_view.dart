// ignore_for_file: prefer_const_constructors, unused_field, strict_raw_type

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../../config/router/app_router.dart';
import '../../core/components/button/animated_icon_button.dart';
import '../../core/components/button/custom_icon_button.dart';
import '../../core/components/button/custom_text_button.dart';
import '../../core/components/text/stroked_auto_size_text.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/rive/rive_constants.dart';
import '../../core/rive/rive_utils.dart';
import '../../core/theme/colors_tones.dart';
import '../bloc/home/home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late StateMachineController _controller;
  late SMITrigger _toggleTheme;

  @override
  void initState() {
    context.read<HomeBloc>().add(const ClearAlertsAndSetAgain());
         FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Home View');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  @override
  void didChangeDependencies() {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Home View');
    super.didChangeDependencies();
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
    return StorekedAutoSizeText(
      text: LocaleKeys.splash_title.tr(),
      fontSize: 75,
      fontWeight: FontWeight.w900,
      strokeColor: ColorsTones2.secondaryColor,
      strokeWidth: 6,
    );
  }

  Widget _playButton() {
    return CustomTextButton(
      onPressed: () async {
        await router.push(const GameRoute());
      },
      text: LocaleKeys.home_play.tr(),
      height: 7.5.h,
      width: 60.w,
    );
  }

  Widget _editButton() {
    return CustomTextButton(
      onPressed: () async {
        await FirebaseAnalytics.instance.logPurchase(
          currency: "deneme satın alımı",
          coupon: "no coupon",
          tax: 0,
          value: 23.5,
        );
      },
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
        // return CustomIconButton(
        //     onPressed: () async {
        //       context.read<HomeBloc>().add(ChangeTheme(context));
        //     },
        //     icon: state.themeAdapter.model.iconData //dark_mode
        //     );
        return AnimatedIconButton(
          onPressed: () {
            _toggleTheme.fire();
            context.read<HomeBloc>().add(
                  ChangeTheme(context),
                );
          },
          child: RiveAnimation.asset(
            RiveConstants.themeAnimationPath,
            onInit: (artboard) {
              _controller =
                  RiveUtils.getController(artboard, stateMachineName: 'theme');
              _toggleTheme =
                  _controller.findInput<bool>('toggleTheme') as SMITrigger;
            },
          ),
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
