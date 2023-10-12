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
    List<ItemList> sync = [
      ItemList('Sincronizadas', countSincronizadas.toDouble()),
      ItemList('Pendientes', countPendientes.toDouble()),
    ];

    List<ItemList> local = [
      ItemList('Completas', countCompletas.toDouble()),
      ItemList('Incompletas', countInCompletas.toDouble()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Fichas')),
      body: Column(
        children: [
          SfCircularChart(
            series: <RadialBarSeries>[
              RadialBarSeries<ItemList, String>(
                dataSource: sync,
                xValueMapper: (ItemList data, _) => data.name,
                yValueMapper: (ItemList data, _) => data.value,
                cornerStyle: CornerStyle.bothCurve,
                innerRadius: '40%',
                maximumValue: sync.fold(
                    0, (max, item) => item.value > max! ? item.value : max),
              ),
            ],
          ),
          SfCircularChart(
            series: <RadialBarSeries>[
              RadialBarSeries<ItemList, String>(
                dataSource: local,
                xValueMapper: (ItemList data, _) => data.name,
                yValueMapper: (ItemList data, _) => data.value,
                cornerStyle: CornerStyle.bothCurve,
                innerRadius: '40%',
                maximumValue: local.fold(
                    0, (max, item) => item.value > max! ? item.value : max),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemList {
  ItemList(this.name, this.value);
  final String name;
  final double value;
}
