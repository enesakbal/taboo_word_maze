part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends GameEvent {
  const FetchData();
}

class StartGame extends GameEvent {
  final Team team1;
  final Team team2;

  const StartGame({
    required this.team1,
    required this.team2,
  });
}

class SkipTaboo extends GameEvent {
  const SkipTaboo();
}

class IncreaseAPoint extends GameEvent {
  const IncreaseAPoint();
}

class DecreaseAPoint extends GameEvent {
  const DecreaseAPoint();
}

class PauseGame extends GameEvent {
  const PauseGame();
}

class ResumeGame extends GameEvent {
  const ResumeGame();
}
