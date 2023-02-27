import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/taboo.dart';
import '../../../domain/entities/team.dart';
import '../../../domain/usecaces/taboo_usecase.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  TabooUsecase tabooUsecase;

  GameBloc(
    this.tabooUsecase,
  ) : super(const GameInitial()) {
    var dataList = <Taboo>[];

    late Team currentTeam;

    var currentPoint = 0;

    Team team1;
    Team team2;

    var isVisible = true;

    on<StartGame>(
      (event, emit) async {
        try {
          // currentPoint = 0;

          currentTeam = event.team1;

          team1 = event.team1;
          team2 = event.team2;

          // var currentTeamName = currentTeam.teamName;
          // var currentTeamPoint = currentTeam.point;

          emit(const GameInitial());
          //* reset state

          if (dataList.isEmpty) {
            dataList = await tabooUsecase.getAllTaboos();
            final seed = Random.secure();
            dataList.shuffle(seed);
          }

          print(dataList.first);
          emit(GameStarted(taboo: dataList.first, point: currentPoint));
        } on Exception catch (_) {}
      },
    );

    on<SkipTaboo>(
      (event, emit) async {
        try {
          final seed = Random.secure();
          dataList.shuffle(seed);

          emit(GameUpdatedStatus(taboo: dataList.first, point: currentPoint));
        } on Exception catch (_) {}
      },
    );

    on<IncreaseAPoint>(
      (event, emit) async {
        try {
          final seed = Random.secure();
          dataList.shuffle(seed);
          currentPoint += 1;
          emit(GameUpdatedStatus(taboo: dataList.first, point: currentPoint));
        } on Exception catch (_) {}
      },
    );

    on<DecreaseAPoint>(
      (event, emit) async {
        try {
          final seed = Random.secure();
          dataList.shuffle(seed);
          currentPoint -= 1;
          emit(GameUpdatedStatus(taboo: dataList.first, point: currentPoint));
        } on Exception catch (_) {}
      },
    );

    on<PauseGame>((event, emit) {
      isVisible = false;
      emit(GamePaused(
        taboo: dataList.first,
        point: currentPoint,
        isVisible: isVisible,
      ));
    });

    on<ResumeGame>((event, emit) {
      isVisible = true;
      emit(
        GameResumed(
          taboo: dataList.first,
          point: currentPoint,
          isVisible: isVisible,
        ),
      );
    });
  }
}
