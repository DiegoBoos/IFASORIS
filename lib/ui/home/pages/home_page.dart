import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifasoris/data/models/afiliado_response_model.dart';
import 'package:ifasoris/domain/usecases/afiliado/afiliado_exports.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';

import '../widgets/app_drawer.dart';
import '../widgets/buttons.dart';
import '../widgets/ficha_form.dart';
import '../widgets/headers.dart';
import '../widgets/mobile_appbar.dart';
import '../widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = SharedPreferencesService();
  AfiliadoEntity? afiliado;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      AfiliadoModel sharedPrefsAfiliado =
          AfiliadoModel.fromJson(await prefs.get('afiliado'));
      setState(() {
        afiliado = sharedPrefsAfiliado;
      });
    } catch (e) {
      afiliado = null;
    }
  }

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            afiliado != null
                ? _Header(
                    afiliado: afiliado,
                  )
                : _EmptyHeader(),
            Column(
              children: [
                FadeInLeft(
                    child: CustomButton(
                        icon: FontAwesomeIcons.dochub,
                        texto: 'Crear ficha',
                        color1: afiliado != null
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.withOpacity(0.5),
                        color2: afiliado != null
                            ? Colors.lightBlue
                            : Colors.grey.withOpacity(0.5),
                        onPress: afiliado != null
                            ? null
                            : () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      return FichaForm();
                                    });
                              })),
              ],
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: const [
                  Text('SIRIS S.A.S'),
                  Text('Última versión 19/04/2021')
                ],
              ),
            )
          ],
        ));
  }
}

class _Header extends StatelessWidget {
  final AfiliadoEntity? afiliado;

  const _Header({this.afiliado});
  @override
  Widget build(BuildContext context) {
    return IconHeader(
        icon: FontAwesomeIcons.userCheck,
        title: '${afiliado?.nombre1} ${afiliado?.nombre2}',
        subtitle: afiliado?.documento ?? '',
        color1: Theme.of(context).colorScheme.primary,
        color2: Colors.green);
  }
}

class _EmptyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconHeader(
        icon: FontAwesomeIcons.userCheck,
        color1: Theme.of(context).colorScheme.primary,
        color2: Colors.green);
  }
}
