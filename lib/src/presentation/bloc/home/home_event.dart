part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ChangeTheme extends HomeEvent {
  final BuildContext context;
  const ChangeTheme(this.context);

  @override
  List<Object> get props => [];
}
class ChangeLocale extends HomeEvent {
  final BuildContext context;
  const ChangeLocale(this.context);

  @override
  List<Object> get props => [];
}
