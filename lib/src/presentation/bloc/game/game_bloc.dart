import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/taboo.dart';
import '../../../domain/usecaces/taboo_usecase.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  TabooUsecase tabooUsecase;

  GameBloc(
    this.tabooUsecase,
  ) : super(const GameInitial()) {
    var dataList = <Taboo>[];

    var currentPoint = 0;

    var isVisible = true;

    on<StartGame>(
      (event, emit) async {
        try {
          currentPoint = 0;
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

    on<StopGame>((event, emit) {
      print('object1');
      isVisible = false;

      emit(GameUpdatedStatus(
        taboo: dataList.first,
        point: currentPoint,
        isVisible: isVisible,
      ));
      print('object2');
    });

    on<ResumeGame>((event, emit) {
      isVisible = true;

      emit(
        GameUpdatedStatus(
          taboo: dataList.first,
          point: currentPoint,
          isVisible: isVisible,
        ),
      );
    });
  }
}
