part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final LocaleAdapter localeAdapter;
  final ThemeAdapter themeAdapter;
  final NotificationAdapter notificationAdapter;

  const HomeState(
      {required this.localeAdapter,
      required this.themeAdapter,
      required this.notificationAdapter});

  @override
  List<Object> get props => [localeAdapter, themeAdapter, notificationAdapter];
}

class HomeInitial extends HomeState {
  const HomeInitial({
    required super.localeAdapter,
    required super.themeAdapter,
    required super.notificationAdapter,
  });
}
