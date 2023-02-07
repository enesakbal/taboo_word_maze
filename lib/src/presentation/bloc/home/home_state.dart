part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final LocaleAdapter localeAdapter;
  final ThemeAdapter themeAdapter;

  const HomeState({required this.localeAdapter, required this.themeAdapter});

  @override
  List<Object> get props => [localeAdapter, themeAdapter];
}

class HomeInitial extends HomeState {
  const HomeInitial({required super.localeAdapter, required super.themeAdapter});
}
