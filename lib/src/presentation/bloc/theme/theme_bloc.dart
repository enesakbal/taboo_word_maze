// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/cache/local_manager.dart';
// import '../../../core/lang/adapter/language_adapter.dart';
// import '../../../core/notifier/theme_notifier.dart';
// import '../home/adapter/settings_adapter.dart';

// part 'theme_event.dart';
// part 'theme_state.dart';

// class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
//   final LocalManager manager;

//   final ThemeSetting<ThemeMode> themeSetting;

//   ThemeBloc({required this.manager, required this.themeSetting})
//       : super(
//           manager.getCurrentThemeMode() == ThemeMode.dark
//               ? const DarkTheme()
//               : const LightTheme(),
//         ) {
//     on<ChangeTheme>(
//       (event, emit) async {
        // await themeSetting.changeState(event.context);

        // final newTheme = manager.getCurrentThemeMode();

        // if (newTheme == ThemeMode.dark) {
        //   emit(const DarkTheme());
        // } else if (newTheme == ThemeMode.light) {
        //   emit(const LightTheme());
        // }
//       },
//     );
//   }
// }
