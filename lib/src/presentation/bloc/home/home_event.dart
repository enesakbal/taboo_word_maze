part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class InitializeAppSettings extends HomeEvent {
  const InitializeAppSettings();

  @override
  List<Object> get props => [];
}
