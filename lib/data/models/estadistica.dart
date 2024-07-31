import '../../domain/entities/estadistica.dart';

class EstadisticaModel extends EstadisticaEntity {
  const EstadisticaModel({
    String? estadistica,
    int? cantidad,
  });

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
