import 'package:flutter/material.dart';
import '../../utils/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        Text('Bienvenido a la Plataforma IFASORIS', style: Styles.titleStyle),
      ]),
    ));
  }
}
