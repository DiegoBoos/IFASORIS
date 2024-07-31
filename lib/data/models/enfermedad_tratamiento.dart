import 'dart:convert';

import 'package:ifasoris/domain/entities/enfermedad_tratamiento.dart';

List<EnfermedadTratamientoModel> enfermedadesTratamientoFromJson(String str) =>
    List<EnfermedadTratamientoModel>.from(
        json.decode(str).map((x) => EnfermedadTratamientoModel.fromJson(x)));

class EnfermedadTratamientoModel extends EnfermedadTratamientoEntity {
  const EnfermedadTratamientoModel({
    int? enfermedadTratamientoId,
    String? descripcion,
  });

  static EnfermedadTratamientoModel fromEntity(
      EnfermedadTratamientoEntity entity) {
    return EnfermedadTratamientoModel(
      enfermedadTratamientoId: entity.enfermedadTratamientoId,
      descripcion: entity.descripcion,
    );
  }

  factory EnfermedadTratamientoModel.fromJson(Map<String, dynamic> json) =>
      EnfermedadTratamientoModel(
        enfermedadTratamientoId: json["EnfermedadTratamiento_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "EnfermedadTratamiento_id": enfermedadTratamientoId,
        "Descripcion": descripcion,
      };
}
