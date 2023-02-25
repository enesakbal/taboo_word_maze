
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/router/app_router.dart';
import '../../../init/lang/locale_keys.g.dart';
import '../../../theme/colors_tones.dart';
import '../../button/custom_text_button.dart';
import '../../text_form_field/custom_text_form_field.dart';
import 'bloc/start_game_dialog_bloc.dart';

class StartGameDialog extends StatelessWidget {
  const StartGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
        titlePadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
        contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 2.h),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.only(bottom: 2.h),
        iconPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        backgroundColor: ColorsTones.lightSkyBlue,
        iconColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        title: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
            color: ColorsTones2.pass,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          alignment: Alignment.topCenter,
          child: AutoSizeText(
            LocaleKeys.home_play_dialog_header.tr(),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: ColorsTones2.black,
            ),
          ),
        ),
        content: Container(
          width: 80.w,
          height: 50.h,
          // color: Colors.red.withOpacity(0.2),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),
                AutoSizeText(
                  LocaleKeys.home_play_dialog_team_1.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 1.h),
                CustomTextFormField(
                  hintText: LocaleKeys.home_play_dialog_placeholder_1.tr(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Divider(
                    height: 16,
                    thickness: 2,
                  ),
                ),
                AutoSizeText(
                  LocaleKeys.home_play_dialog_team_2.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 1.h),
                CustomTextFormField(
                  hintText: LocaleKeys.home_play_dialog_placeholder_2.tr(),
                ),
                SizedBox(height: 2.h),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Divider(
                    height: 16,
                    thickness: 2,
                  ),
                ),
                AutoSizeText(
                  LocaleKeys.home_play_dialog_time.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 1.h),
                BlocBuilder<StartGameDialogBloc, StartGameDialogState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextButton(
                          height: 7.5.h,
                          width: 7.5.h,
                          onPressed: () {
                            context
                                .read<StartGameDialogBloc>()
                                .add(const ChangeSelectedTime(time: '30'));
                          },
                          text: '30',
                          maxLines: 2,
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                          backgroundColor: ColorsTones2.fail,
                          borderSideColor: state.time == '30'
                              ? Colors.black
                              : Colors.transparent,
                        ),
                        CustomTextButton(
                          height: 7.5.h,
                          width: 7.5.h,
                          onPressed: () {
                            context
                                .read<StartGameDialogBloc>()
                                .add(const ChangeSelectedTime(time: '60'));
                          },
                          text: '60',
                          maxLines: 2,
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                          backgroundColor: ColorsTones2.pass,
                          borderSideColor: state.time == '60'
                              ? Colors.black
                              : Colors.transparent,
                        ),
                        CustomTextButton(
                          height: 7.5.h,
                          width: 7.5.h,
                          onPressed: () {
                            context
                                .read<StartGameDialogBloc>()
                                .add(const ChangeSelectedTime(time: '90'));
                          },
                          text: '90',
                          maxLines: 2,
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                          backgroundColor: ColorsTones2.success,
                          borderSideColor: state.time == '90'
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
        actions: [
          BlocBuilder<StartGameDialogBloc, StartGameDialogState>(
            builder: (context, state) {
              return CustomTextButton(
                onPressed: () async {
                  await router
                      .push(NGameRoute(duration: int.parse(state.time)));
                },
                text: LocaleKeys.home_play_dialog_start.tr(),
                fontSize: 35,
                width: 50.w,
                height: 6.h,
              );
            },
          ),
        ],
      ),
    );
  }
}

extension Show on StartGameDialog {
  Future<T?> show<T>(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return this;
      },
    );
  }
}
