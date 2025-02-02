import '../../domain/entities/estadistica.dart';

class EstadisticaModel extends EstadisticaEntity {
  const EstadisticaModel({
    super.estadistica,
    super.cantidad,
  });

  factory EstadisticaModel.fromEntity(EstadisticaEntity entity) {
    return EstadisticaModel(
      estadistica: entity.estadistica,
      cantidad: entity.cantidad,
    );
  }

  factory EstadisticaModel.fromJson(Map<String, dynamic> json) =>
      EstadisticaModel(
        estadistica: json["Estadistica"],
        cantidad: json["Cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "Estadistica": estadistica,
        "Cantidad": cantidad,
      };
}
