import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
import '../../config/router/app_router.dart';
import '../../core/components/dialogs/error_dialog.dart';
import '../../core/components/text/scale_animated_stroked_text.dart';
import '../../core/lang/locale_keys.g.dart';
import '../../core/theme/colors_tones.dart';
import '../bloc/splash/splash_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<SplashBloc>().add(const BusinessDesicion());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async {
        print(state);
        if (state is NeedUpdate) {
          await ErrorDialog(
            text: state.message,
          ).show(context);
        } else if (state is SplashLocalDBHasData) {
          await router.replace(const HomeRoute());
        } else if (state is SplashFetchedDataFromFirebase) {
          await router.replace(const HomeRoute());
        } else if (state is SplashNoData) {
          print('no data');
          await ErrorDialog(text: state.message).show(context);
        } else if (state is SplashError) {
          print('no data');
          await ErrorDialog(text: state.message).show(context);
        }
      },
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Container _buildBody() {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: ColorTones.softBlue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _headers(),
          _loadingAnimation(),
        ],
      ),
    );
  }

  Widget _headers() {
    return Container(
      // color: Colors.red,
      height: 60.h,
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ScaleAnimatedStorekedText(
              textAlign: TextAlign.center,
              text: LocaleKeys.splash_title.tr(),
              strokeColor: Colors.black,
              strokeWidth: 4,
              fontSize: 60,
            ),
          ),
          Center(
            child: ScaleAnimatedStorekedText(
              textAlign: TextAlign.center,
              text: LocaleKeys.splash_subtitle.tr(),
              strokeColor: Colors.black,
              strokeWidth: 4,
              fontSize: 60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingAnimation() {
    return Stack(
      children: [
        Container(
          height: 40.h,
          width: 100.w,
          child: const Align(
            alignment: Alignment.center,
            child: RiveAnimation.asset(
              'assets/animation/loading.riv',
            ),
          ),
        ),
        Container(
          height: 30.h,
          width: 100.w,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  LocaleKeys.splash_loading.tr(),
                  style: const TextStyle(
                    fontFamily: 'ChakraPetch',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  isRepeatingAnimation: true,
                  animatedTexts: [
                    TyperAnimatedText(
                      '...',
                      curve: Curves.linear,
                      speed: const Duration(milliseconds: 500),
                      textStyle: const TextStyle(
                        fontFamily: 'ChakraPetch',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
