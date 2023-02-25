import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'start_game_dialog_event.dart';
part 'start_game_dialog_state.dart';

class StartGameDialogBloc
    extends Bloc<StartGameDialogEvent, StartGameDialogState> {
  StartGameDialogBloc() : super(const StartGameDialogInitial('30')) {
    var time = '30';

    on<ChangeSelectedTime>((event, emit) {
      time = event.time;
      emit(StartGameDialogInitial(time));
    });
  }
}
