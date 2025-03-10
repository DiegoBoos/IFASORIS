import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/entities/afiliado_entity.dart';
import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';
import '../../blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';
import '../../blocs/estilo_vida_saludable/estilo_vida_saludable_bloc.dart';
import '../../blocs/grupo_familiar/grupo_familiar_bloc.dart';
import '../../cubits/familia/familia_cubit.dart';
import '../../cubits/ficha/ficha_cubit.dart';
import '../../utils/custom_snack_bar.dart';
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
    final grupoFamiliarBloc = BlocProvider.of<GrupoFamiliarBloc>(context);
    final estiloVidaSaludableBloc =
        BlocProvider.of<EstiloVidaSaludableBloc>(context);
    final cuidadoSaludCondRiesgoBloc =
        BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context);
    final dimensionSocioCulturalPueblosIndigenasBloc =
        BlocProvider.of<DimensionSocioCulturalPueblosIndigenasBloc>(context);
    final atencionSaludBloc = BlocProvider.of<AtencionSaludBloc>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<AfiliadoPrefsBloc, AfiliadoPrefsState>(
            listener: (context, state) {
              if (state is AfiliadoLoaded) {
                dimUbicacionBloc.add(DimUbicacionInit());
                dimViviendaBloc.add(DimViviendaInit());
                grupoFamiliarBloc.add(GrupoFamiliarInit());
                estiloVidaSaludableBloc.add(EstiloVidaSaludableInit());
                cuidadoSaludCondRiesgoBloc.add(CuidadoSaludCondRiesgoInit());
                dimensionSocioCulturalPueblosIndigenasBloc
                    .add(DimensionSocioCulturalPueblosIndigenasInit());
                atencionSaludBloc.add(AtencionSaludInit());
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
                                                  await eliminarFicha(
                                                      context, state);
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

  Future<void> eliminarFicha(BuildContext context, AfiliadoLoaded state) async {
    final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);

    await afiliadoBloc
        .afiliadoTieneFicha(state.afiliado!.afiliadoId!)
        .then((ficha) async {
      if (ficha != null) {
        final familiaCubit = BlocProvider.of<FamiliaCubit>(context);
        final fichaCubit = BlocProvider.of<FichaCubit>(context);

        //Elimina el afiliado de la familia
        final familiaFuture =
            familiaCubit.deleteAfiliadoFamilia(state.afiliado!.afiliadoId!);

        //Elimina la ficha
        final fichaFuture = fichaCubit.deleteFicha(ficha.fichaId!);

        final futures = Future.wait([familiaFuture, fichaFuture]);

        futures.then((value) {
          int familiaId = value[0];
          int fichaId = value[1];

          if (familiaId != 0 && fichaId != 0) {
            afiliadoPrefsBloc
                .add(const DeleteAfiliado('Ficha eliminada correctamente'));
          }
        });
      } else {
        afiliadoBloc.add(
            const ErrorMessage('No se puede eliminar una ficha incompleta'));
      }
    });
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
            '${afiliado?.nombre1 ?? ''} ${afiliado?.nombre2 ?? ''} ${afiliado?.apellido1 ?? ''} ${afiliado?.apellido2 ?? ''}',
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
