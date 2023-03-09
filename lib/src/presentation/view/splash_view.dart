import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
import '../../config/router/app_router.dart';
import '../../core/components/dialogs/error_dialog.dart';
import '../../core/components/text/stroked_auto_size_text.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/rive/rive_constants.dart';
import '../../core/rive/rive_utils.dart';
import '../../core/theme/colors_tones.dart';
import '../bloc/splash/splash_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late StateMachineController? _jumpingAnimationController;
  late SMITrigger touched;
  //** jumping pokemon controller and trigger name

  late RiveAnimationController<RuntimeArtboard> _dotController;
  //* dot animation controller

  late AnimationController? _scaleAnimationController;
  late Animation<double> _scaleAnimation;
  //* scale transition

  late AnimationController? _headerAnimationController;
  late Animation<double> _headerAnimation;
  //* header scale animation

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then(
        (value) => context.read<SplashBloc>().add(const BusinessDesicion()));

    _dotController = OneShotAnimation('load');
    //* 'load' from rive.app.com (custom value)

    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1, milliseconds: 250),
    );
    //* duration : the length of time this animation should last.
    //* if u want to use .forward(). you must add a value inside of duration parameter

    _scaleAnimation = Tween<double>(begin: 1, end: 20)
        .chain(CurveTween(curve: Curves.fastOutSlowIn))
        .animate(
          _scaleAnimationController!,
        );
    //* scale 1x to 20x

    _headerAnimationController = AnimationController(
      vsync: this,
    )..repeat(
        reverse: true,
        period: const Duration(seconds: 1),
      );
    //* repeat : starts running this animation in the forward direction, and restarts the animation when it completes.
    //* period : animation period

    _headerAnimation = Tween<double>(begin: 1, end: 1.10).animate(
      _headerAnimationController!,
    );

    super.initState();
  }

  @override
  void dispose() {
    _jumpingAnimationController!.dispose();
    _scaleAnimationController!.dispose();
    _headerAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async {
        log(state.runtimeType.toString());
        if (state is NeedUpdate) {
          await ErrorDialog(
            text: state.message,
          ).show(context);
        } else if (state is SplashLocalDBHasData ||
            state is SplashFetchedDataFromFirebase) {
          await _scaleAnimationController?.forward().whenComplete(() async {
            await router.replace(const HomeRoute());
          });
          //* wait for the animation to finish
        } else if (state is SplashError) {
          await ErrorDialog(text: state.message).show(context);
        }
      },
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: ScaleTransition(
        scale: _scaleAnimation,
        alignment: const Alignment(0.1, 0.1),
        child: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 7.5.h),
              _title(),
              Expanded(flex: 2, child: _jumpingAnimation()),
              SizedBox(height: 2.5.h),
              Expanded(flex: 1, child: _dotAnimaiton()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return ScaleTransition(
      scale: _headerAnimation,
      child: StorekedAutoSizeText(
        text: LocaleKeys.splash_title.tr(),
        fontSize: 70,
        fontWeight: FontWeight.w900,
        strokeColor: ColorsTones.secondaryColor,
        strokeWidth: 6,
      ),
    );
  }

  Widget _jumpingAnimation() {
    return Container(
      height: 50.h,
      width: 100.w,
      child: Align(
        alignment: Alignment.center,
        child: RiveAnimation.asset(
          RiveConstants.jumpingAnimationPath,
          fit: BoxFit.cover,
          onInit: (artboard) {
            _jumpingAnimationController = RiveUtils.getController(artboard,
                stateMachineName: 'State Machine 1');

            touched = _jumpingAnimationController!.findInput<bool>('touched')
                as SMITrigger;

            Timer.periodic(
              const Duration(seconds: 1, milliseconds: 500),
              (timer) {
                touched.fire();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _dotAnimaiton() {
    return RiveAnimation.asset(
      RiveConstants.loadingAnimationPath,
      controllers: [_dotController],
    );
  }
}
