import 'package:flutter/material.dart';

class AlreadyAppliedDialog extends StatelessWidget {
  const AlreadyAppliedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('¡Has aplicado en los últimos 3 meses!'),
      content: const Text(
        'Recuerda que debes esperar 3 meses antes de volver a aplicar a un crédito con nosotros.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
