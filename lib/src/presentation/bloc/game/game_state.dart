part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  final Taboo taboo;
  final int point;
  final bool isVisible;

  const GameState({
    this.taboo = const Taboo(word: '', forbiddenWords: ',,,,'),
    this.point = 0,
    this.isVisible = true,
  });

  @override
  List<Object> get props => [taboo, point, isVisible];
}

class GameInitial extends GameState {
  const GameInitial();
}

class GameStarted extends GameState {
  const GameStarted({
    super.taboo,
    super.point,
  });
}

class GameUpdatedStatus extends GameState {
  const GameUpdatedStatus({
    super.taboo,
    super.point,
    super.isVisible,
  });
}
class GamePaused extends GameState {
  const GamePaused({
    super.taboo,
    super.point,
    super.isVisible,
  });
}
class GameResumed extends GameState {
  const GameResumed({
    super.taboo,
    super.point,
    super.isVisible,
  });
}
