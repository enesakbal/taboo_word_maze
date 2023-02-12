import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/lang/adapter/language_adapter.dart';
import '../../../core/notifications/local/adapter/notification_adapter.dart';
import '../../../core/theme/adapter/theme_adapter.dart';
import 'adapter/settings_adapter.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LangSetting<LocaleAdapter> langSetting;

  final ThemeSetting<ThemeAdapter> themeSetting;

  final NotificationSetting<NotificationAdapter> notificationSetting;


  HomeBloc(this.langSetting, this.themeSetting, this.notificationSetting)
      : super(HomeInitial(
          themeAdapter: themeSetting.currentAdapter,
          localeAdapter: langSetting.currentAdapter,
          notificationAdapter: notificationSetting.currentAdapter,
        )) {
    on<ClearAlertsAndSetAgain>((event, emit) {
      return notificationSetting.cancelAllAlertsAndSetAlerts();
    });

    on<ChangeTheme>((event, emit) async {
      await themeSetting.changeState(event.context);
      add(const UpdateState());
    });

    on<ChangeLocale>((event, emit) async {
      await langSetting.changeState(event.context);
      add(const UpdateState());
    });

    on<ChangeNotification>((event, emit) async {
      await notificationSetting.changeState(event.context);
      add(const UpdateState());
    });

    on<UpdateState>(
      (event, emit) => emit(
        HomeInitial(
          themeAdapter: themeSetting.currentAdapter,
          localeAdapter: langSetting.currentAdapter,
          notificationAdapter: notificationSetting.currentAdapter,
        ),
      ),
    );
  }
}
