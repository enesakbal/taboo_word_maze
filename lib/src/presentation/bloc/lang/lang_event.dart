part of 'lang_bloc.dart';

abstract class LangEvent extends Equatable {
  const LangEvent();

  @override
  List<Object> get props => [];
}

class ChangeLocale extends LangEvent {
  final BuildContext context;
  const ChangeLocale({required this.context});

  @override
  List<Object> get props => [context];
}
