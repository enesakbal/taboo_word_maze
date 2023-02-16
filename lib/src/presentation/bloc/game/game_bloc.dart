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
  ) : super(GameInitial()) {
    var dataList = <Taboo>[];

    var currentPoint = 0;

    on<StartGame>(
      (event, emit) async {
        try {
          emit(GameInitial());
          //* reset state

          if (dataList.isEmpty) {
            dataList = await tabooUsecase.getAllTaboos();
            final seed = Random.secure();
            dataList.shuffle(seed);
          }

          emit(GameStarted(taboo: dataList.first, point: currentPoint));
        } on Exception catch (_) {}
      },
    );

    on<SkipTaboo>(
      (event, emit) async {
        try {
          final seed = Random.secure();
          dataList.shuffle(seed);

          emit(GameSkippedTaboo(taboo: dataList.first, point: currentPoint));
        } on Exception catch (_) {}
      },
    );

    on<IncreaseAPoint>(
      (event, emit) async {
        try {
          final seed = Random.secure();
          dataList.shuffle(seed);
          currentPoint += 1;
          emit(GameAddedAPoint(taboo: dataList.first, point: currentPoint));
        } on Exception catch (_) {}
      },
    );

    
    on<DecreaseAPoint>(
      (event, emit) async {
        try {
          final seed = Random.secure();
          dataList.shuffle(seed);
          currentPoint -= 1;
          emit(GameAddedAPoint(taboo: dataList.first, point: currentPoint));
        } on Exception catch (_) {}
      },
    );

    // on<GameEvent>((event, emit) {
    //   print('objectDSFADFASFS');
    // });
  }
}
