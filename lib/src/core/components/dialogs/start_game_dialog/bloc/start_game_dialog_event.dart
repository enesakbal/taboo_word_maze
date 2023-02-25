part of 'start_game_dialog_bloc.dart';

abstract class StartGameDialogEvent extends Equatable {
  const StartGameDialogEvent();

  @override
  List<Object> get props => [];
}

class ChangeSelectedTime extends StartGameDialogEvent {
  const ChangeSelectedTime({
    required this.time,
  });
  final String time;

  @override
  List<Object> get props => [time];
}
