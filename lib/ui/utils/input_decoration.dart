import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration inputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon,
      IconButton? suffixIcon,
      Function()? onPressed}) {
    return InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: const OutlineInputBorder(),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(icon: suffixIcon, onPressed: onPressed)
            : null);
  }
}
