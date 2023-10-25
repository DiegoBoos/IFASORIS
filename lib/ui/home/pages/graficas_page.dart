import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficasPage extends StatelessWidget {
  const GraficasPage({
    required this.countCompletas,
    required this.countInCompletas,
    required this.countSincronizadas,
    required this.countPendientes,
    super.key,
  });

  final int countCompletas;
  final int countInCompletas;
  final int countSincronizadas;
  final int countPendientes;

  @override
  Widget build(BuildContext context) {
    List<_PieData> syncedPendingCounts = [
      _PieData('Sincronizadas: $countSincronizadas',
          countSincronizadas.toDouble(), 'Sincronizadas'),
      _PieData('Pendientes: $countPendientes', countPendientes.toDouble(),
          'Pendientes'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Fichas')),
      body: Column(
        children: [
          SfCircularChart(
            title: ChartTitle(text: 'Fichas sincronizadas y diligenciadas'),
            legend: Legend(isVisible: true),
            series: <PieSeries<_PieData, String>>[
              PieSeries<_PieData, String>(
                  explode: true,
                  explodeIndex: 0,
                  dataSource: syncedPendingCounts,
                  xValueMapper: (_PieData data, _) => data.xData,
                  yValueMapper: (_PieData data, _) => data.yData,
                  dataLabelMapper: (_PieData data, _) => data.text,
                  dataLabelSettings: const DataLabelSettings(isVisible: true)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text = '']);
  final String xData;
  final num yData;
  final String text;
}
