import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';
import '../../search/search_afiliados.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/eliminar_ficha.dart';
import '../widgets/app_drawer.dart';
import '../widgets/buttons.dart';

class _PieData {
  _PieData(this.xData, this.yData, [this.text = '']);
  final String xData;
  final num yData;
  final String text;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageViewCtrl = PageController();

  List<_PieData> syncedPendingCounts = [
    _PieData('Sincronizadas: 2', 2, 'Sincronizadas'),
    _PieData('Diligenciadas: 1', 1.toDouble(), 'Diligenciadas'),
  ];

  @override
  void initState() {
    super.initState();
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
    afiliadoPrefsBloc.add(LoadAfiliado());
  }

  @override
  Widget build(BuildContext context) {
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
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                'Ficha',
              ),
              centerTitle: true,
            ),
            drawer: const AppDrawer(),
            body: ListView(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                        color: Theme.of(context).colorScheme.primary),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                      ),
                      child: GestureDetector(
                        onTap: () {
                          final afiliadoBloc =
                              BlocProvider.of<AfiliadoBloc>(context);
                          showSearch(
                              context: context,
                              delegate:
                                  SearchAfiliados(afiliadoBloc: afiliadoBloc));
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
                    )),
                BlocBuilder<AfiliadoPrefsBloc, AfiliadoPrefsState>(
                    builder: (context, state) {
                  if (state is AfiliadoLoaded) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                pageViewCtrl.animateToPage(0,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Consulta',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                pageViewCtrl.animateToPage(1,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Sincronizadas',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                pageViewCtrl.animateToPage(2,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Pendientes',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 300,
                          child: PageView(
                            controller: pageViewCtrl,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Column(
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
                                            Navigator.pushNamed(
                                                context, 'ficha');
                                          })),
                                  FadeInRight(
                                      child: CustomButton(
                                          icon: FontAwesomeIcons.trash,
                                          texto: 'Eliminar ficha',
                                          color1: Colors.red,
                                          color2: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          onPress: () async {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Eliminar ficha'),
                                                    content: const Text(
                                                        '¿Está seguro de eliminar la ficha?'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: const Text(
                                                              'Cancelar')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                            await eliminarFicha(
                                                                context,
                                                                state
                                                                    .afiliadoLoaded!);
                                                          },
                                                          child: const Text(
                                                              'Aceptar'))
                                                    ],
                                                  );
                                                });
                                          })),
                                ],
                              ),
                              const Text('Sincronizadas'),
                              const Text('Pendientes'),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                }),
                SfCircularChart(
                  title: ChartTitle(
                      text: 'Fichas Diligenciadas vs Sincronizadas',
                      alignment: ChartAlignment.near,
                      textStyle: const TextStyle(
                        color: Colors.black,
                      )),
                  legend: Legend(isVisible: true),
                  series: <PieSeries<_PieData, String>>[
                    PieSeries<_PieData, String>(
                        explode: true,
                        explodeIndex: 0,
                        dataSource: syncedPendingCounts,
                        xValueMapper: (_PieData data, _) => data.xData,
                        yValueMapper: (_PieData data, _) => data.yData,
                        dataLabelMapper: (_PieData data, _) => data.text,
                        dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(color: Colors.white))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(children: const [
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
                  ]),
                )
              ],
            )));
  }
}
