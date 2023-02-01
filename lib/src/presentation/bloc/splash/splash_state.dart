part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashLocalDBHasData extends SplashState {
  final List<Taboo> data;

  const SplashLocalDBHasData({required this.data});

  @override
  List<Object> get props => [data];
}

class SplashFetchedDataFromFirebase extends SplashState {
  final List<Taboo> data;

  const SplashFetchedDataFromFirebase({required this.data});

  @override
  List<Object> get props => [data];
}

class SplashNoData extends SplashState {
  final String message;

  const SplashNoData({required this.message});

  @override
  List<Object> get props => [message];
}

class SplashError extends SplashState {
  final String message;

  const SplashError({required this.message});

  @override
  List<Object> get props => [message];
}

class NeedUpdate extends SplashState {
  final String message;

  const NeedUpdate({required this.message});

  @override
  List<Object> get props => [message];
}
