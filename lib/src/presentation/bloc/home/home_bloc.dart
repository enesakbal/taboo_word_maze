import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/lang/adapter/language_adapter.dart';
import '../../../core/theme/adapter/theme_adapter.dart';
import 'adapter/settings_adapter.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LangSetting<LocaleAdapter> langSetting;

  final ThemeSetting<ThemeAdapter> themeSetting;

  HomeBloc(this.langSetting, this.themeSetting)
      : super(HomeInitial(
          themeAdapter: themeSetting.currentAdapter,
          localeAdapter: langSetting.currentAdapter,
        )) {
    on<ChangeTheme>((event, emit) async {
      await themeSetting.changeState(event.context);

      emit(
        HomeInitial(
          themeAdapter: themeSetting.currentAdapter,
          localeAdapter: langSetting.currentAdapter,
        ),
      );
    });

    on<ChangeLocale>((event, emit) async {
      await langSetting.changeState(event.context);

      emit(
        HomeInitial(
          themeAdapter: themeSetting.currentAdapter,
          localeAdapter: langSetting.currentAdapter,
        ),
      );
    });
  }
}
