import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/router/app_router.dart';
import '../../../init/extensions/string_extensions.dart';
import '../../../init/lang/locale_keys.g.dart';
import '../../../theme/colors_tones.dart';
import '../../button/custom_text_button.dart';
import '../../text_form_field/custom_text_form_field.dart';
import '../dialog_interface.dart';
import 'bloc/start_game_dialog_bloc.dart';

class StartGameDialog extends IDialog {
  StartGameDialog({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _team1Controller = TextEditingController();
  final TextEditingController _team2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
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
      title: _title(),
      content: _content(),
      actions: _actions(),
    );
  }

  List<Widget> _actions() {
    return [
      BlocBuilder<StartGameDialogBloc, StartGameDialogState>(
        builder: (context, state) {
          return CustomTextButton(
            onPressed: () async {
              context.read<StartGameDialogBloc>().add(
                    const ChangeHasPressedState(),
                  );
              // //*
              //   _team1Controller.text = 'Enes';
              //   _team2Controller.text = 'Akbal';
              // //*

              if (_formKey.currentState!.validate()) {
                await router.replace(
                  GameRoute(
                    duration: int.parse(state.time),
                  ),
                );
              }
            },
            text: LocaleKeys.home_play_dialog_start.tr(),
            fontSize: 35,
            width: 50.w,
            height: 6.h,
          );
        },
      ),
    ];
  }

  Container _content() {
    return Container(
      height: 50.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              AutoSizeText(
                LocaleKeys.home_play_dialog_team_1.tr(),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 1.h),
              BlocBuilder<StartGameDialogBloc, StartGameDialogState>(
                builder: (context, state) {
                  return CustomTextFormField(
                    controller: _team1Controller,
                    validator: (val) => val!.isValidTeamName,
                    onChanged: (_) => state.hasPressed
                        ? _formKey.currentState!.validate()
                        : null,
                    hintText: LocaleKeys.home_play_dialog_placeholder_1.tr(),
                  );
                },
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 1.h),
              BlocBuilder<StartGameDialogBloc, StartGameDialogState>(
                builder: (context, state) {
                  return CustomTextFormField(
                    controller: _team2Controller,
                    validator: (val) => val!.isValidTeamName,
                    onChanged: (_) => state.hasPressed
                        ? _formKey.currentState!.validate()
                        : null,
                    hintText: LocaleKeys.home_play_dialog_placeholder_2.tr(),
                  );
                },
              ),
              SizedBox(height: 1.h),
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 2.h),
              BlocBuilder<StartGameDialogBloc, StartGameDialogState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _timeButton(context, state,
                          time: '30', color: ColorsTones2.fail),
                      _timeButton(context, state,
                          time: '60', color: ColorsTones2.pass),
                      _timeButton(context, state,
                          time: '90', color: ColorsTones2.success),
                    ],
                  );
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeButton(
    BuildContext context,
    StartGameDialogState state, {
    required String time,
    required Color color,
  }) {
    return CustomTextButton(
      height: 7.5.h,
      width: 7.5.h,
      onPressed: () {
        context
            .read<StartGameDialogBloc>()
            .add(ChangeSelectedTime(time: (int.parse(time) + 1).toString()));
      },
      text: time,
      maxLines: 2,
      fontWeight: FontWeight.w900,
      fontSize: 50,
      backgroundColor: color,
      borderSideColor: state.time == (int.parse(time) + 1).toString()
          ? Colors.black
          : Colors.transparent,
    );
  }

  Container _title() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorsTones2.pass,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      alignment: Alignment.topCenter,
      child: Text(
        LocaleKeys.home_play_dialog_header.tr(),
        style: TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.bold,
          color: ColorsTones2.black,
        ),
      ),
    );
  }

  @override
  Future<T?> show<T>(BuildContext context, {bool isDissmissible = true}) {
    return super.show(context, isDissmissible: isDissmissible);
  }
}
