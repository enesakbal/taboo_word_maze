part of 'start_game_dialog_bloc.dart';

abstract class StartGameDialogState extends Equatable {
  const StartGameDialogState(this.time);

  final String time;

  @override
  List<Object> get props => [time];
}

class StartGameDialogInitial extends StartGameDialogState {
  const StartGameDialogInitial(super.time);

  @override
  List<Object> get props => [time];
}
