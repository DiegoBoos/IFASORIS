import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifasoris/core/constants.dart';

import '../../../theme/styles.dart';
import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';
import '../../search/search_afiliados.dart';
import '../../utils/custom_alerts.dart';
import '../helpers/eliminar_ficha.dart';
import '../widgets/app_drawer.dart';
import '../widgets/buttons.dart';
import '../widgets/fichas_sincronizadas.dart';
import '../widgets/graficas.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? pageViewCtrl;
  int _currentPage = 0; // Track the current page

  @override
  void initState() {
    super.initState();
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
    pageViewCtrl = PageController()
      ..addListener(() {
        setState(() {
          _currentPage = pageViewCtrl!.page!.round(); // Update the current page
        });
      });
    afiliadoPrefsBloc.add(LoadAfiliado());
  }

  @override
  void dispose() {
    pageViewCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);
    final dimViviendaBloc = BlocProvider.of<DimViviendaBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AfiliadoPrefsBloc, AfiliadoPrefsState>(
          listener: (context, state) {
            if (state is AfiliadoLoaded) {
              final afiliado = state.afiliado!;
              dimUbicacionBloc.add(
                  GetDimUbicacion(afiliado.afiliadoId!, afiliado.familiaId!));
              dimViviendaBloc.add(
                  GetDimVivienda(afiliado.afiliadoId!, afiliado.familiaId!));
            }
            if (state is AfiliadoError) {
              context.showErrorSnackBar(
                  message: 'Error al guardar el afiliado');
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Ficha',
          ),
          centerTitle: true,
        ),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            const Header(),
            BlocBuilder<AfiliadoPrefsBloc, AfiliadoPrefsState>(
              builder: (context, state) {
                if (state is AfiliadoLoaded) {
                  return Expanded(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  pageViewCtrl?.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: Styles.buttonStyle(_currentPage ==
                                    0), // Update based on current page
                                child: const Text(
                                  'Diligenciar ficha',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageViewCtrl?.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: Styles.buttonStyle(_currentPage ==
                                    1), // Update based on current page
                                child: const Text(
                                  'Fichas completadas',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageViewCtrl?.animateToPage(
                                    2,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: Styles.buttonStyle(_currentPage ==
                                    2), // Update based on current page
                                child: const Text(
                                  'Consultar fichas sincronizadas',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: pageViewCtrl,
                            scrollDirection: Axis.horizontal,
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    FadeInLeft(
                                      child: CustomButton(
                                        icon: FontAwesomeIcons.dochub,
                                        texto: 'Diligenciar ficha',
                                        color1: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        color2: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onPress: () {
                                          Navigator.pushNamed(context, 'ficha');
                                        },
                                      ),
                                    ),
                                    FadeInRight(
                                      child: CustomButton(
                                        icon: FontAwesomeIcons.trash,
                                        texto: 'Eliminar ficha',
                                        color1: Colors.red,
                                        color2:
                                            Theme.of(context).colorScheme.error,
                                        onPress: () async {
                                          CustomAlerts.showCustomDialog(
                                            context,
                                            'Eliminar ficha',
                                            '¿Está seguro de eliminar la ficha?',
                                            () async {
                                              Navigator.pop(context);
                                              await eliminarFicha(context,
                                                  state.afiliadoLoaded!);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SingleChildScrollView(
                                child: Graficas(),
                              ),
                              const Center(
                                child: SingleChildScrollView(
                                    child: FichasSincronizadas()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: const [
                  Text(
                    'IFASORIS',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'MALLAMAS EPS INDIGENA',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Última actualización: 23/08/2024',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        child: GestureDetector(
          onTap: () {
            final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);
            showSearch(
              context: context,
              delegate: SearchAfiliados(afiliadoBloc: afiliadoBloc),
            );
          },
          child: const TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Buscar afiliado',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none, // No underline
              prefixIcon: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
