part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  final Taboo taboo;
  final int point;

  const GameState({
    this.taboo = const Taboo(word: '', forbiddenWords: ',,,,'),
    this.point = 0,
  });

  @override
  List<Object> get props => [taboo, point];
}

class GameInitial extends GameState {}

class GameFetchedData extends GameState {
  const GameFetchedData({
    super.taboo,
  });
}

class GameStarted extends GameState {
  const GameStarted({
    super.taboo,
    super.point,
  });
}

class GameSkippedTaboo extends GameState {
  const GameSkippedTaboo({
    required super.taboo,
    required super.point,
  });
}

class GameAddedAPoint extends GameState {
  const GameAddedAPoint({
    required super.taboo,
    required super.point,
  });
}
