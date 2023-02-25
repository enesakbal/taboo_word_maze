import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'start_game_dialog_event.dart';
part 'start_game_dialog_state.dart';

class StartGameDialogBloc
    extends Bloc<StartGameDialogEvent, StartGameDialogState> {
  StartGameDialogBloc() : super(const StartGameDialogInitial('91')) {
    var time = '91';

    on<ChangeSelectedTime>((event, emit) {
      time = event.time;
      emit(StartGameDialogInitial(time));
    });
  }
}
