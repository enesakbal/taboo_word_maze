part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends GameEvent {}

class StartGame extends GameEvent {}

class SkipTaboo extends GameEvent {}

class IncreaseAPoint extends GameEvent {}

class DecreaseAPoint extends GameEvent {}

class StopGame extends GameEvent {}

class ResumeGame extends GameEvent {}
