import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/lang/adapter/language_adapter.dart';
import '../../../core/lang/language_manager.dart';

part 'lang_event.dart';
part 'lang_state.dart';

class LangBloc extends Bloc<LangEvent, LangState> {
  LangBloc() : super(LangInitial(localeAdapter: LanguageManager.getAdapter())) {
    on<ChangeLocale>((event, emit) {
      final turkish = TurkishLocale().model.locale;
      final english = EnglishLocale().model.locale;

      if (event.context.locale == TurkishLocale().model.locale) {
        event.context.setLocale(english);
        emit(LangInitial(localeAdapter: EnglishLocale()));
      } else {
        event.context.setLocale(turkish);
        emit(LangInitial(localeAdapter: TurkishLocale()));
      }
      return;
    });
  }
}
