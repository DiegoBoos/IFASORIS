import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/models/estadistica.dart';
import '../../blocs/ficha/ficha_bloc.dart';

class Graficas extends StatefulWidget {
  const Graficas({super.key});

  @override
  State<Graficas> createState() => _GraficasState();
}

class _GraficasState extends State<Graficas> {
  int countCompletas = 0;
  int countInCompletas = 0;
  int countSincronizadas = 0;
  int countPendientes = 0;
  int countAfiliadosRegistrados = 0;
  int countAfiliadosReportados = 0;

  @override
  void initState() {
    super.initState();
    loadEstadisticas();
  }

  void loadEstadisticas() async {
    final fichaBloc = BlocProvider.of<FichaBloc>(context);
    final estadisticas = await fichaBloc.loadEstadisticas();

    countCompletas = estadisticas
        .firstWhere((i) => i.estadistica == 'FichasRegistradasCompletas',
            orElse: () => const EstadisticaModel(cantidad: 0))
        .cantidad!;
    countInCompletas = estadisticas
        .firstWhere((i) => i.estadistica == 'FichasRegistradasIncompletas',
            orElse: () => const EstadisticaModel(cantidad: 0))
        .cantidad!;
    countPendientes = estadisticas
        .firstWhere((i) => i.estadistica == 'FichasReportadas',
            orElse: () => const EstadisticaModel(cantidad: 0))
        .cantidad!;
    countSincronizadas = estadisticas
        .firstWhere((i) => i.estadistica == 'FichasRegistradas',
            orElse: () => const EstadisticaModel(cantidad: 0))
        .cantidad!;
    countAfiliadosRegistrados = estadisticas
        .firstWhere((i) => i.estadistica == 'AfiliadosReportados',
            orElse: () => const EstadisticaModel(cantidad: 0))
        .cantidad!;
    countAfiliadosReportados = estadisticas
        .firstWhere((i) => i.estadistica == 'AfiliadosRegistrados',
            orElse: () => const EstadisticaModel(cantidad: 0))
        .cantidad!;
  }

  @override
  Widget build(BuildContext context) {
    List<_PieData> syncedPendingCounts = [
      _PieData('Sincronizadas: $countSincronizadas',
          countSincronizadas.toDouble(), 'Sincronizadas'),
      _PieData('Diligenciadas: $countPendientes', countPendientes.toDouble(),
          'Diligenciadas'),
    ];

    return Column(
      children: [
        SfCircularChart(
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
        DataTable(
          columns: const [
            DataColumn(label: Text('Estadistica')),
            DataColumn(label: Text('Cantidad')),
          ],
          rows: [
            DataRow(
              cells: [
                const DataCell(Text('Fichas Registradas')),
                DataCell(Text(countPendientes.toString())),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text('Fichas Reportadas')),
                DataCell(Text(countSincronizadas.toString())),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text('Fichas Registradas Incompletas')),
                DataCell(Text(countInCompletas.toString())),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text('Fichas Registradas Completas')),
                DataCell(Text(countCompletas.toString())),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text('Afiliados Registrados')),
                DataCell(Text(countAfiliadosRegistrados.toString())),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text('Afiliados Reportados')),
                DataCell(Text(countAfiliadosReportados.toString())),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text = '']);
  final String xData;
  final num yData;
  final String text;
}
