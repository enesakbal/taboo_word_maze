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

class ChangeHasPressedState extends StartGameDialogEvent {
  const ChangeHasPressedState();

  @override
  List<Object> get props => [];
}
class ResetState extends StartGameDialogEvent {
  const ResetState();

  @override
  List<Object> get props => [];
}
