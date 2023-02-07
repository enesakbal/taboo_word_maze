part of 'lang_bloc.dart';

abstract class LangState extends Equatable {
  final LocaleAdapter localeAdapter;
  const LangState({required this.localeAdapter});

  @override
  List<Object> get props => [localeAdapter];
}

class LangInitial extends LangState {
  const LangInitial({required super.localeAdapter});

  @override
  List<Object> get props => [localeAdapter];
}
