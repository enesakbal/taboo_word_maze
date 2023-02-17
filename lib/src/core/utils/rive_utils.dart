import 'package:rive/rive.dart';

class RiveUtils {
  static SMIBool getRiveInput(Artboard artboard,
      {required String stateMachineName}) {
    final controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);

    artboard.addController(controller!);

    return controller.findInput<bool>('active') as SMIBool;
  }


  static StateMachineController _onCheckRiveInit(
    Artboard artboard, {
    String stateMachineName = 'State Machine 1',
    required Map<String, SMITrigger> data,
  }) {
    final controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);

    return controller;
  }

  static void chnageSMIBoolState(SMIBool input) {
    input.change(true);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        input.change(false);
      },
    );
  }
}
