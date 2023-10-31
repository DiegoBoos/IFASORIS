import '../../domain/entities/estadistica_entity.dart';

class EstadisticaModel extends EstadisticaEntity {
  EstadisticaModel({
    required String estadistica,
    required int cantidad,
  }) : super(estadistica: estadistica, cantidad: cantidad);

  factory EstadisticaModel.fromJson(Map<String, dynamic> json) =>
      EstadisticaModel(
        estadistica: json["Estadistica"],
        cantidad: json["Cantidad"],
      );
}
