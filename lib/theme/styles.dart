import 'package:flutter/material.dart';

class Styles {
  static const Color lightGreen = Color(0XFF11AF4E);
  static const Color obscureGreen = Color(0XFF36BA67);
  static const titleStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  static const subtitleStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

  static LinearGradient getColorGradient(Color color) {
    var baseColor = color as dynamic;
    Color color1 = baseColor[800];
    Color color2 = baseColor[400];
    return LinearGradient(colors: [
      color1,
      color2,
    ], begin: Alignment.bottomLeft, end: Alignment.topRight);
  }

  static ButtonStyle buttonStyle(bool isActive) {
    return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: isActive
            ? MaterialStateProperty.all<Color>(Colors.grey.shade300)
            : null);
  }
}
