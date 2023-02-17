import 'package:rive/rive.dart';

class RiveModel {
  final String path;
  final String stateMachineName;

  RiveModel({
    required this.path,
    required this.stateMachineName,
  });

  StateMachineController? getStateMachineController(Artboard? artboard) {
    return StateMachineController.fromArtboard(artboard!, stateMachineName);
  }
}

//todo 
