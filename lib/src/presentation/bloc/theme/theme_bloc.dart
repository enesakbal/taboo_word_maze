import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/cache/local_manager.dart';
import '../../../core/notifier/theme_notifier.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final LocalManager manager;
  ThemeBloc({required this.manager})
      : super(
          manager.getCurrentThemeMode() == ThemeMode.dark
              ? const DarkTheme()
              : const LightTheme(),
        ) {
    on<ChangeTheme>(
      (event, emit) async {
        await Provider.of<ThemeModeNotifier>(event.context, listen: false)
            .changeTheme();

        final newTheme = manager.getCurrentThemeMode();

        if (newTheme == ThemeMode.dark) {
          emit(const DarkTheme());
        } else if (newTheme == ThemeMode.light) {
          emit(const LightTheme());
        }
      },
    );
  }
}
