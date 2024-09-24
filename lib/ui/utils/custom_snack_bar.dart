import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  static Future<dynamic> showCustomDialog(
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

  static Future<dynamic> exitDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Salir de la ficha'),
          content: const Text('¿Está seguro que desea salir?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
            ),
          ],
        );
      },
    );
  }
}
