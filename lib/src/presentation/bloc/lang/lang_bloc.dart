// import 'package:bloc/bloc.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// import '../../../core/lang/adapter/language_adapter.dart';
// import '../../../core/lang/language_manager.dart';
// import '../home/adapter/settings_adapter.dart';

// part 'lang_event.dart';
// part 'lang_state.dart';

// class LangBloc extends Bloc<LangEvent, LangState> {
//   final LangSetting<LocaleAdapter> settingsAdapter;

//   LangBloc(this.settingsAdapter)
//       : super(LangInitial(localeAdapter: LanguageManager.getAdapter())) {
//     on<ChangeLocale>((event, emit) async {
//       await settingsAdapter.changeState(event.context);

//       emit(LangInitial(localeAdapter: settingsAdapter.currentAdapter));
//     });
//   }
// }
