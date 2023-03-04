import 'package:flutter/material.dart';

abstract class IDialog extends StatelessWidget {
  const IDialog({super.key});

  Future<T?> show<T>(BuildContext context, {bool isDissmissible = false}) {
    return showDialog(
      context: context,
      barrierDismissible: isDissmissible,
      builder: (context) {
        return this;
      },
    );
  }
}
