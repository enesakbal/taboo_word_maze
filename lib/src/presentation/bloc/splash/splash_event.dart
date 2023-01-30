part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends SplashEvent {
  const FetchData();

  @override
  List<Object> get props => [];
}
