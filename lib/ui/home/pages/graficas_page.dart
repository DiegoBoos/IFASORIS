import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficasPage extends StatelessWidget {
  const GraficasPage({
    required this.countCompletas,
    required this.countInCompletas,
    required this.countSincronizadas,
    required this.countPendientes,
    required this.countAfiliadosRegistrados,
    required this.countAfiliadosReportados,
    super.key,
  });

  final int countCompletas;
  final int countInCompletas;
  final int countSincronizadas;
  final int countPendientes;
  final int countAfiliadosRegistrados;
  final int countAfiliadosReportados;

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
          title: ChartTitle(text: 'Fichas Diligenciadas vs Sincronizadas'),
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
