import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/components/button/custom_text_button.dart';
import '../../core/components/text/stroked_auto_size_text.dart';
import '../../core/theme/colors_tones.dart';
import '../bloc/game/game_bloc.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  void initState() {
    context.read<GameBloc>().add(StartGame());
    print('object');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {},
      child: Scaffold(
        body: _buildBody(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StorekedAutoSizeText(
                text: 'Caner',
                fontSize: 40,
                textColor: ColorsTones.azure,
                strokeColor: ColorsTones.dark,
                strokeWidth: 7,
              ),
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return AutoSizeText(
                    ' ${state.point} Point',
                    style: const TextStyle(
                      fontSize: 40,
                      // color: Colors.black,
                    ),
                  );
                },
              ),
            ],
          ),
          // backgroundColor: Colors.red,
          toolbarHeight: 7.5.h,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsTones.darkSkyBlue,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 4,
          ),
        ),
        height: 85.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60.h,
              width: 100.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 2.h),
                  Container(
                    width: 75.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      color: ColorsTones.darkRed,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 4,
                      ),
                    ),
                    child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        return AutoSizeText(
                          state.taboo.word!,
                          maxLines: 1,
                          style: TextStyle(
                            color: ColorsTones.azure,
                            fontWeight: FontWeight.w600,
                            fontSize: 45,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 5; i++) _forbidden(i),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextButton(
                      onPressed: () {
                        context.read<GameBloc>().add(IncreaseAPoint());
                      },
                      text: 'Correct',
                      height: 7.5.h,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: CustomTextButton(
                      onPressed: () {
                        context.read<GameBloc>().add(DecreaseAPoint());
                      },
                      text: 'Taboo',
                      height: 7.5.h,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: CustomTextButton(
                      onPressed: () {
                        context.read<GameBloc>().add(SkipTaboo());
                      },
                      text: 'Skip',
                      height: 7.5.h,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15.h,
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 50.w,
                      height: 10.h,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          '01:30:00',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forbidden(
    int i,
  ) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          width: 100.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 4,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            state.taboo.forbiddenWords!.split(',')[i],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        );
      },
    );
  }
}
