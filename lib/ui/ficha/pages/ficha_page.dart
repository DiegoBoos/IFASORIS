import 'package:flutter/material.dart';
import 'package:ifasoris/ui/ficha/widgets/slide_show.dart';

import '../../utils/custom_snack_bar.dart';
import 'dim_ubicacion_page.dart';
import 'dim_vivienda_page.dart';
import 'grupo_familiar_page.dart';

class FichaPage extends StatefulWidget {
  const FichaPage({super.key});

  @override
  State<FichaPage> createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          CustomSnackBar.showCustomDialog(
              context,
              'Está seguro que desea salir',
              'Se perderán los datos no guardados.', () {
            Navigator.popUntil(context, ModalRoute.withName('home'));
            return;
          });
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Ficha'),
            ),
            body: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme:
                        const ColorScheme.light(primary: Colors.green)),
                child: Slideshow(
                  pageViewController: pageViewController,
                  puntosArriba: true,
                  slides: [
                    DimUbicacionPage(pageViewController),
                    DimViviendaPage(pageViewController),
                    GrupoFamiliarPage(pageViewController)
                  ],
                ))));
  }
}
