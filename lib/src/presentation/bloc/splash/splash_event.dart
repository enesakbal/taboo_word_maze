part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class FetchDataFromFirebase extends SplashEvent {
  const FetchDataFromFirebase();

  @override
  List<Object> get props => [];
}

class FetchDataFromLocalDB extends SplashEvent {
  final bool hasInternetConnection;
  const FetchDataFromLocalDB({required this.hasInternetConnection});

  @override
  List<Object> get props => [];
}

class HasUpdate extends SplashEvent {
  const HasUpdate();

  @override
  List<Object> get props => [];
}

class BusinessDesicion extends SplashEvent {
  const BusinessDesicion();

  @override
  List<Object> get props => [];
}
