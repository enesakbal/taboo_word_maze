part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  final Taboo tabooData;
  final Team team;
  final bool isVisible;
  final int skipCount;

  const GameState({
    required this.tabooData,
    required this.team,
    this.isVisible = true,
    this.skipCount = 3,
  });

  @override
  List<Object> get props => [tabooData, team, isVisible, skipCount];
}

class GameInitial extends GameState {
  const GameInitial(
      {required super.tabooData, required super.team, super.isVisible = false});

  @override
  List<Object> get props => [tabooData, team, isVisible, skipCount];
}

class GameStarted extends GameState {
  const GameStarted(
      {required super.tabooData, required super.team, super.isVisible = false});

  @override
  List<Object> get props => [tabooData, team, isVisible, skipCount];
}

class GameUpdatedStatus extends GameState {
  const GameUpdatedStatus({
    required super.tabooData,
    required super.team,
    required super.skipCount,
    super.isVisible,
  });
  @override
  List<Object> get props => [tabooData, team, isVisible, skipCount];
}

class GamePaused extends GameState {
  final Team team1;
  final Team team2;
  const GamePaused({
    required super.tabooData,
    required this.team1,
    required this.team2,
    required super.team,
    super.isVisible,
    super.skipCount,
  });
  @override
  List<Object> get props =>
      [tabooData, team, team1, team2, isVisible, skipCount];
}

class GameResumed extends GameState {
  const GameResumed({
    required super.tabooData,
    required super.team,
    super.isVisible,
    super.skipCount,
  });

  @override
  List<Object> get props => [tabooData, team, isVisible, skipCount];
}

class GameRoundEnded extends GameState {
  const GameRoundEnded({
    required super.tabooData,
    required super.team,
    super.isVisible,
    super.skipCount,
  });

  @override
  List<Object> get props => [tabooData, team, isVisible, skipCount];
}
