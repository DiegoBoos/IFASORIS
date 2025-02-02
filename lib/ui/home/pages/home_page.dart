import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifasoris/domain/usecases/familia/familia_exports.dart';
import 'package:ifasoris/ui/utils/custom_svg.dart';

import '../../../theme/styles.dart';
import '../../blocs/afiliados/afiliados_bloc.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';
import '../../cubits/afiliado/afiliado_cubit.dart';
import '../../cubits/ficha/ficha_cubit.dart';
import '../../utils/custom_alerts.dart';
import '../widgets/app_drawer.dart';
import '../widgets/buttons.dart';
import '../widgets/fichas_sincronizadas.dart';
import '../widgets/graficas.dart';
import '../widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AfiliadoPrefsBloc afiliadoPrefsBloc;
  late AfiliadosBloc afiliadosBloc;

  PageController? pageViewCtrl;
  int _currentPage = 0; // Track the current page

  @override
  void initState() {
    super.initState();
    afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
    afiliadosBloc = BlocProvider.of<AfiliadosBloc>(context);

    pageViewCtrl = PageController()
      ..addListener(() {
        setState(() {
          _currentPage = pageViewCtrl!.page!.round(); // Update the current page
        });
      });
    afiliadoPrefsBloc.add(const LoadAfiliado());
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
    final familiaCubit = context.read<FamiliaCubit>();
    final fichaCubit = context.read<FichaCubit>();

    return MultiBlocListener(
      listeners: [
        BlocListener<AfiliadoPrefsBloc, AfiliadoPrefsState>(
          listener: (context, state) {
            if (state is AfiliadoPrefsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error al guardar el afiliados'),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is AfiliadoPrefsLoaded) {
              final afiliado = state.afiliado!;
              dimUbicacionBloc.add(
                  GetDimUbicacion(afiliado.afiliadoId!, afiliado.familiaId!));
              dimViviendaBloc.add(
                  GetDimVivienda(afiliado.afiliadoId!, afiliado.familiaId!));
            }
          },
        ),
        BlocListener<AfiliadoCubit, AfiliadoState>(
          listener: (context, state) {
            if (state is AfiliadoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is AfiliadoFichaReportada) {
              //Elimina el afiliado de la familia
              final afiliadoPrefsBloc =
                  BlocProvider.of<AfiliadoPrefsBloc>(context);
              final afiliadoId = afiliadoPrefsBloc.state.afiliado!.afiliadoId;
              familiaCubit.deleteAfiliadoFamilia(afiliadoId!);
            }
          },
        ),
        BlocListener<FamiliaCubit, FamiliaState>(
          listener: (context, state) {
            if (state is FamiliaError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is FamiliaEliminada) {
              //Elimina la ficha
              fichaCubit.deleteFicha(state.fichaId);
            }
          },
        ),
        BlocListener<FichaCubit, FichaState>(listener: (context, state) {
          if (state is FichaError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is FichaEliminada) {
            afiliadoPrefsBloc.add(DeleteAfiliado());
          }
        })
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Header(),
            BlocBuilder<AfiliadoPrefsBloc, AfiliadoPrefsState>(
              builder: (context, state) {
                if (state is AfiliadoPrefsLoaded) {
                  return Expanded(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    pageViewCtrl?.animateToPage(
                                      0,
                                      duration:
                                          const Duration(milliseconds: 200),
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
                                      duration:
                                          const Duration(milliseconds: 200),
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
                                      duration:
                                          const Duration(milliseconds: 200),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: RichText(
                            text: TextSpan(
                              text: 'Ficha de ',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${state.afiliado!.nombre1} ${state.afiliado!.nombre2} ${state.afiliado!.apellido1} ${state.afiliado!.apellido2}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
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
                                        onPress: () {
                                          CustomAlerts.showCustomDialog(
                                            context,
                                            'Eliminar ficha',
                                            '¿Está seguro de eliminar la ficha?',
                                            () {
                                              final afiliadoCubit =
                                                  context.read<AfiliadoCubit>();
                                              afiliadoCubit.eliminarFicha(
                                                  state.afiliado!.afiliadoId!);
                                              Navigator.pop(context);
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
                                child: FichasSincronizadas(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return CustomSvg(title: 'No hay afiliado seleccionado');
              },
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Text(
                    'IFASORIS',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'MALLAMAS EPS INDIGENA',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Última actualización: 02/02/2025',
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
