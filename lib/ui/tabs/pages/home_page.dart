import 'package:flutter/material.dart';

import '../../utils/styles.dart';
import '../widgets/app_drawer.dart';
import '../widgets/mobile_appbar.dart';
import '../widgets/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: size.width > 500
            ? PreferredSize(
                preferredSize: size,
                child: const NavBar(),
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(size.height * 0.08),
                child: const MobileAppBar()),
        drawer: const AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Bienvenido a la Plataforma IFASORIS',
                    style: Styles.titleStyle),
              ]),
        ));
  }
}
