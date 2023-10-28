import '../../domain/entities/estadistica_entity.dart';

class EstadisticaModel extends EstadisticaEntity {
  EstadisticaModel({
    required String descripcion,
    required int cantidad,
  }) : super(descripcion: descripcion, cantidad: cantidad);

  factory EstadisticaModel.fromJson(Map<String, dynamic> json) =>
      EstadisticaModel(
        descripcion: json["Descripcion"],
        cantidad: json["Cantidad"],
      );
}
