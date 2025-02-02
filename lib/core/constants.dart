import 'package:flutter/material.dart';

class Constants {
  // Api Producción
  static const apiLocal = 'http://172.17.1.42:9098/api';
  static const apiPublica = 'http://190.121.144.14:9098/api';

  // Api Sincronización
  static const syncLocal = 'http://172.17.1.42:5005/api';
  static const syncPublica = 'http://190.121.144.134:5005/api';

  /// Simple preloader inside a Center widget
  static const preloader =
      Center(child: CircularProgressIndicator(color: Colors.orange));

  /// Simple sized box to space out form elements
  static const formSpacer = SizedBox(width: 16, height: 16);

  /// Some padding for all the forms to use
  static const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 16);

  /// Error message to display when an unexpected error occurs
  static const unexpectedErrorMessage = 'Excepción no controlada';
}
