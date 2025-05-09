import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color1;
  final Color color2;

  const IconHeader(
      {super.key,
      required this.icon,
      this.title = '',
      this.subtitle = '',
      this.color1 = Colors.grey,
      this.color2 = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(80)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color1, color2])),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center),
          Text(
            subtitle,
            style: const TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          BounceInDown(
            child: FaIcon(
              icon,
              size: 80,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
