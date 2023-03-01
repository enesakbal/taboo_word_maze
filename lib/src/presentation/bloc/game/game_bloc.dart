import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/round.dart';
import '../../../domain/entities/taboo.dart';
import '../../../domain/entities/team.dart';
import '../../../domain/usecaces/taboo_usecase.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  TabooUsecase tabooUsecase;

  GameBloc(
    this.tabooUsecase,
  ) : super(GameInitial(
          isVisible: false,
          tabooData: const Taboo(word: '', forbiddenWords: ',,,,'),
          team: Team(),
        )) {
    //*
    var dataList = <Taboo>[];

    late int roundNumber;
    late Round currentRound;

    late Team team1;
    late Team team2;

    late Team currentTeam;

    final seed = Random.secure();

    on<StartGame>(
      (event, emit) async {
        try {
          team1 = event.team1;
          team2 = event.team2;

          roundNumber = 1;

          currentRound = Round(roundNumber: roundNumber);
          currentTeam = team1;

          if (dataList.isEmpty) {
            dataList = await tabooUsecase.getAllTaboos();

            dataList.shuffle(seed);
          }

          print(dataList.first);
          emit(GameStarted(tabooData: dataList.first, team: currentTeam));
        } on Exception catch (e) {
          print(e);
        }
      },
    );

    on<SkipTaboo>(
      (event, emit) async {
        try {
          dataList.shuffle(seed);

          currentRound.increasePass();

          emit(GameUpdatedStatus(tabooData: dataList.first, team: currentTeam));
        } on Exception catch (e) {
          print(e);
        }
      },
    );

    on<IncreaseAPoint>(
      (event, emit) async {
        try {
          dataList.shuffle(seed);

          currentTeam.increaseAPoint();
          currentRound.increaseSuccess();

          emit(GameUpdatedStatus(tabooData: dataList.first, team: currentTeam));
        } on Exception catch (e) {
          print(e);
        }
      },
    );

    on<DecreaseAPoint>(
      (event, emit) async {
        try {
          dataList.shuffle(seed);

          currentTeam.decreaseAPoint();
          currentRound.increaseFail();

          emit(GameUpdatedStatus(tabooData: dataList.first, team: currentTeam));
        } on Exception catch (e) {
          print(e);
        }
      },
    );

    on<PauseGame>((event, emit) {
      try {
        emit(GamePaused(
          tabooData: dataList.first,
          team: currentTeam,
          isVisible: false,
          team1: team1,
          team2: team2,
        ));
      } on Exception catch (e) {
        print(e);
      }
    });

    on<ResumeGame>((event, emit) {
      try {
        emit(GameResumed(tabooData: dataList.first, team: currentTeam));
      } on Exception catch (e) {
        print(e);
      }
    });

    on<EndOfRound>((event, emit) {
      try {
        currentTeam.roundList!.add(currentRound);
        currentRound = Round(roundNumber: roundNumber);

        if (currentTeam == team1) {
          currentTeam = team2;
        } else if (currentTeam == team2) {
          roundNumber += 1;
          currentTeam = team1;
        }

        // print("*****");
        // print(team1);
        // print("*****");
        // print(team2);
        // print("*****");

        emit(
          GameResumed(
            tabooData: dataList.first,
            team: currentTeam,
            isVisible: true,
          ),
        );
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
