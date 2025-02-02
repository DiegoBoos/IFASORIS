// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  final IconData? icon;
  @required
  final String? texto;
  final Color? color1;
  final Color color2;
  final Color colorTitulo;
  final Color colorIcono;
  final Color colorArrow;
  @required
  final Function? onPress;

  const CustomButton(
      {this.icon,
      this.texto,
      this.color1 = Colors.grey,
      this.color2 = Colors.blue,
      this.colorTitulo = Colors.white,
      this.colorIcono = Colors.white,
      this.colorArrow = Colors.white,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress as void Function()?,
      child: Stack(
        children: [
          _ButtonBackground(icon, color1, color2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 140, width: 40),
              FaIcon(icon, color: colorIcono, size: 40),
              const SizedBox(width: 20),
              Expanded(
                child: Text(texto!,
                    style: TextStyle(color: colorTitulo, fontSize: 18)),
              ),
              FaIcon(FontAwesomeIcons.chevronRight, color: colorArrow),
              const SizedBox(width: 40),
            ],
          )
        ],
      ),
    );
  }
}

class _ButtonBackground extends StatelessWidget {
  final IconData? icon;
  final Color? color1;
  final Color color2;

  const _ButtonBackground(this.icon, this.color1, this.color2);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                offset: const Offset(4, 6),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [color1!, color2])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: FaIcon(icon,
                  size: 150, color: Colors.white.withValues(alpha: 0.2)),
            )
          ],
        ),
      ),
    );
  }
}
