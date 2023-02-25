import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../../core/components/button/custom_icon_button.dart';
import '../../core/rive/rive_constants.dart';
import '../../core/rive/rive_utils.dart';
import '../../core/theme/colors_tones.dart';
import '../bloc/game/game_bloc.dart';

class NGameView extends StatefulWidget {
  const NGameView({super.key, required this.duration});

  final int duration;

  @override
  State<NGameView> createState() => _NGameViewState();
}

class _NGameViewState extends State<NGameView> {
  late CountDownController _timerController;

  late StateMachineController? _bearAnimationController;
  late SMITrigger _success;
  late SMITrigger _fail;

  @override
  void initState() {
    context.read<GameBloc>().add(StartGame());

    _timerController = CountDownController();
    super.initState();
  }

  @override
  void dispose() {
    _bearAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.only(right: 4.w, left: 4.w, bottom: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(child: _bearAnimation()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 9.h,
                      width: 9.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorsTones2.success,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: ColorsTones2.azure2,
                          width: 5,
                        ),
                      ),
                      child: BlocBuilder<GameBloc, GameState>(
                        builder: (context, state) {
                          return AutoSizeText(
                            state.point.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: ColorsTones2.azure2,
                            ),
                          );
                        },
                      ),
                    ),
                    _timer(),
                  ],
                )
              ],
            ),
            SizedBox(height: 2.h),
            _asd(),
            SizedBox(height: 2.h),
            SizedBox(height: 2.h),
            _buttons(),
          ],
        ),
      ),
    );
  }

  Widget _timer() {
    return CircularCountDownTimer(
      height: 8.h,
      width: 8.h,
      duration: widget.duration,
      initialDuration: 0,
      controller: _timerController,
      ringColor: ColorsTones2.azure3,
      fillColor: ColorsTones2.fail,
      backgroundColor: ColorsTones2.pass,
      strokeWidth: 10,
      strokeCap: StrokeCap.butt,
      textStyle: TextStyle(
        fontSize: 25,
        color: ColorsTones2.azure,
        fontWeight: FontWeight.bold,
      ),
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
      },
      onChange: (timeStamp) {
        debugPrint('Countdown Changed $timeStamp');
      },
    );
  }

  Widget _bearAnimation() {
    return Container(
      height: 20.h,
      width: 65.w,
      // color: Colors.grey.shade200,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: RiveAnimation.asset(
        RiveConstants.bearAnimationPath,
        fit: BoxFit.fitWidth,
        alignment: const Alignment(0, -0.175),
        onInit: (artboard) {
          _bearAnimationController = RiveUtils.getController(artboard,
              stateMachineName: 'Login Machine');

          _success = _bearAnimationController!.findInput<bool>('trigSuccess')
              as SMITrigger;

          _fail = _bearAnimationController!.findInput<bool>('trigFail')
              as SMITrigger;
        },
      ),
    );
  }

  Widget _buttons() {
    return Container(
      width: 75.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomIconButton(
            onPressed: () {
              context.read<GameBloc>().add(IncreaseAPoint());
              _success.fire();
            },
            color: ColorsTones2.success,
            shadowLightColor: Colors.transparent,
            border: const NeumorphicBorder.none(),
            icon: Icons.check_outlined,
            buttonSize: 1.75,
          ),
          SizedBox(width: 2.w),
          CustomIconButton(
            onPressed: () {
              context.read<GameBloc>().add(SkipTaboo());
            },
            color: ColorsTones2.pass,
            shadowLightColor: Colors.transparent,
            border: const NeumorphicBorder.none(),
            icon: Icons.skip_next,
            buttonSize: 1.75,
          ),
          SizedBox(width: 2.w),
          CustomIconButton(
            onPressed: () {
              context.read<GameBloc>().add(DecreaseAPoint());
              _fail.fire();
              _timerController.start();
            },
            color: ColorsTones2.fail,
            shadowLightColor: Colors.transparent,
            border: const NeumorphicBorder.none(),
            icon: Icons.close_outlined,
            buttonSize: 1.75,
          ),
        ],
      ),
    );
  }

  Widget _asd() {
    return Expanded(
      child: Container(
        height: 55.h,
        width: 75.w,
        decoration: BoxDecoration(
          color: ColorsTones2.azure2,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          // border: Border.all(color: Colors.white),
        ),
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: ColorsTones2.pass,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(25)),
                      // border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.w),
                        child: AutoSizeText(
                          state.taboo.word!,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Spacer(),
                SizedBox(height: 2.h),
                for (var i = 0; i < 5; i++) ...[
                  _forbidden(i),
                  if (i != 4)
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Divider(
                        height: 16,
                        thickness: 2,
                      ),
                    ),
                ],
                SizedBox(height: 2.h),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _forbidden(int i) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Expanded(
          child: Center(
            child: Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 0.h),
              decoration: const BoxDecoration(
                  // color: Colors.red,
                  ),
              child: AutoSizeText(
                state.taboo.forbiddenWords!.split(',')[i],
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
