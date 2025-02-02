import 'package:flutter/material.dart';

class CustomAlerts {
  static Future<bool?> showCustomDialog(
      BuildContext context, String title, String content, Function()? onPressed,
      [bool showCancel = true]) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text('Aceptar'),
            ),
            if (showCancel)
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
          ],
        );
      },
    );
  }
}
