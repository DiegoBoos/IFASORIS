import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/entities/afiliado_entity.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/eliminar_ficha.dart';
import '../widgets/app_drawer.dart';
import '../widgets/buttons.dart';
import '../widgets/headers.dart';
import '../widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
    afiliadoPrefsBloc.add(LoadAfiliado());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);
    final dimViviendaBloc = BlocProvider.of<DimViviendaBloc>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<AfiliadoPrefsBloc, AfiliadoPrefsState>(
            listener: (context, state) {
              // Una vez que se carga el afiliado, se cargan los datos de las dos dimensiones
              if (state is AfiliadoLoaded) {
                final afiliado = state.afiliado!;
                dimUbicacionBloc.add(
                    GetDimUbicacion(afiliado.afiliadoId!, afiliado.familiaId!));
                dimViviendaBloc.add(
                    GetDimVivienda(afiliado.afiliadoId!, afiliado.familiaId!));
              }
              if (state is AfiliadoError) {
                CustomSnackBar.showSnackBar(
                    context, 'Error al guardar el afiliado', Colors.red);
              }
            },
          ),
        ],
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(size.height * 0.08),
                child: const CustomAppBar()),
            drawer: const AppDrawer(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<AfiliadoPrefsBloc, AfiliadoPrefsState>(
                    builder: (context, state) {
                  if (state is AfiliadoLoaded) {
                    return Column(
                      children: [
                        _Header(
                          afiliado: state.afiliado,
                        ),
                        FadeInLeft(
                            child: CustomButton(
                                icon: FontAwesomeIcons.dochub,
                                texto: 'Diligenciar ficha',
                                color1: Theme.of(context).colorScheme.primary,
                                color2: Theme.of(context).colorScheme.secondary,
                                onPress: () {
                                  Navigator.pushNamed(context, 'ficha');
                                })),
                        FadeInRight(
                            child: CustomButton(
                                icon: FontAwesomeIcons.trash,
                                texto: 'Eliminar ficha',
                                color1: Colors.red,
                                color2: Theme.of(context).colorScheme.error,
                                onPress: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Eliminar ficha'),
                                          content: const Text(
                                              '¿Está seguro de eliminar la ficha?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Cancelar')),
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  await eliminarFicha(context,
                                                      state.afiliadoLoaded!);
                                                },
                                                child: const Text('Aceptar'))
                                          ],
                                        );
                                      });
                                })),
                      ],
                    );
                  }
                  return _EmptyHeader();
                }),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: const [
                      Text('IFASORIS'),
                      Text('MALLAMAS EPS INDIGENA')
                    ],
                  ),
                )
              ],
            )));
  }
}

class _Header extends StatelessWidget {
  final AfiliadoEntity? afiliado;

  const _Header({this.afiliado});
  @override
  Widget build(BuildContext context) {
    return IconHeader(
        icon: FontAwesomeIcons.userCheck,
        title:
            '${afiliado?.nombre1} ${afiliado?.nombre2} ${afiliado?.apellido1} ${afiliado?.apellido2}',
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
