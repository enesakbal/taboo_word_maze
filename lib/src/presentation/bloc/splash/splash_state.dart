part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashLocalDBHasData extends SplashState {
  const SplashLocalDBHasData();
}

class SplashFetchedDataFromFirebase extends SplashState {
  const SplashFetchedDataFromFirebase();
}

class SplashError extends SplashState {
  final String message;

  const SplashError({required this.message});

  @override
  List<Object> get props => [message];
}

class NeedUpdate extends SplashState {
  final String message;
  final void Function() onPressed;

  const NeedUpdate({required this.message,required this.onPressed});

  @override
  List<Object> get props => [message];
}
