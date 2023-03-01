part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  final Taboo tabooData;
  final Team team;
  final bool isVisible;

  const GameState({
    required this.tabooData,
    required this.team,
    this.isVisible = true,
  });

  @override
  List<Object> get props => [tabooData, team, isVisible];
}

class GameInitial extends GameState {
  const GameInitial(
      {required super.tabooData, required super.team, super.isVisible = false});
}

class GameStarted extends GameState {
  const GameStarted(
      {required super.tabooData, required super.team, super.isVisible = false});
}

class GameUpdatedStatus extends GameState {
  const GameUpdatedStatus({
    required super.tabooData,
    required super.team,
    super.isVisible,
  });
}

class GamePaused extends GameState {
  final Team team1;
  final Team team2;
  const GamePaused({
    required super.tabooData,
    required super.team,
    super.isVisible,
    required this.team1,
    required this.team2,
  });
}

class GameResumed extends GameState {
  const GameResumed({
    required super.tabooData,
    required super.team,
    super.isVisible,
  });
}
