import 'package:flutter/material.dart';

import '../../../config/router/app_router.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          await router.pop();
        },
        child: const Text('button'));
  }
}
