// ignore_for_file: prefer_const_constructors, strict_raw_type

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
import '../../core/constants/app_constants.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/theme/colors_tones.dart';
import '../bloc/splash/splash_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late SMITrigger touch;

  late RiveAnimationController _dotController;
  late StateMachineController? _jumpingAnimationController;

  late AnimationController? _scaleAnimationController;
  late Animation<double> _scaleAnimation;

  late AnimationController? _headerAnimationController;
  late Animation<double> _headerAnimation;

  @override
  void initState() {
  
    Future.delayed(Duration(seconds: 3)).then(
        (value) => context.read<SplashBloc>().add(const BusinessDesicion()));

    _dotController = OneShotAnimation('load');

    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1,milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 20)
        .chain(CurveTween(curve: Curves.fastOutSlowIn))
        .animate(
          _scaleAnimationController!,
        );

    _headerAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

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
        } else if (state is SplashLocalDBHasData) {
          await _scaleAnimationController?.forward().whenComplete(() async {
            await router.replace(const HomeRoute());
          });
        } else if (state is SplashFetchedDataFromFirebase) {
          await _scaleAnimationController?.forward().whenComplete(() async {
            await router.replace(const HomeRoute());
          });
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
        alignment: Alignment(0.1, 0.1),
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
        strokeColor: ColorsTones2.secondaryColor,
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
          ApplicationConstants.LOADING_RIVE,
          fit: BoxFit.cover,
          onInit: (artboard) {
            _jumpingAnimationController = StateMachineController.fromArtboard(
                artboard, 'State Machine 1');
            artboard.addController(_jumpingAnimationController!);
            touch = _jumpingAnimationController!.findInput<bool>('touched')
                as SMITrigger;
            Timer.periodic(
              Duration(seconds: 1, milliseconds: 500),
              (timer) {
                touch.fire();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _dotAnimaiton() {
    return RiveAnimation.asset(
      ApplicationConstants.LOADING_RIVE2,
      controllers: [_dotController],
    );
  }
}
