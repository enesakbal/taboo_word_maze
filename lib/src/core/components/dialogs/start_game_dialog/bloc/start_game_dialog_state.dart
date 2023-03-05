part of 'start_game_dialog_bloc.dart';

abstract class StartGameDialogState extends Equatable {
  const StartGameDialogState({this.time = '91', this.hasPressed = false});

  final String time;
  final bool hasPressed;

  @override
  List<Object> get props => [time, hasPressed];
}

class StartGameDialogInitial extends StartGameDialogState {
  const StartGameDialogInitial({super.time, super.hasPressed});

  @override
  List<Object> get props => [time, hasPressed];
}
