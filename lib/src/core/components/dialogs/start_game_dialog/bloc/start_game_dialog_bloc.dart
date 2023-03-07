import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'start_game_dialog_event.dart';
part 'start_game_dialog_state.dart';

class StartGameDialogBloc
    extends Bloc<StartGameDialogEvent, StartGameDialogState> {
  StartGameDialogBloc()
      : super(const StartGameDialogInitial(
          hasPressed: false,
        )) {
    var time = '91';
    var hasPressed = false;

    on<ChangeSelectedTime>((event, emit) {
      time = event.time;
      emit(StartGameDialogInitial(time: time, hasPressed: hasPressed));
    });

    on<ChangeHasPressedState>((event, emit) {
      hasPressed = true;
      emit(StartGameDialogInitial(time: time, hasPressed: hasPressed));
    });

    on<ResetState>((event, emit) {
      hasPressed = false;
      emit(StartGameDialogInitial(time: time, hasPressed: hasPressed));
    });
  }
}
