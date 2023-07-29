import 'dart:convert';

import 'package:ifasoris/domain/entities/enfermedad_tratamiento_entity.dart';

List<EnfermedadTratamientoModel> enfermedadesTratamientoFromJson(String str) =>
    List<EnfermedadTratamientoModel>.from(
        json.decode(str).map((x) => EnfermedadTratamientoModel.fromJson(x)));

class EnfermedadTratamientoModel extends EnfermedadTratamientoEntity {
  EnfermedadTratamientoModel({
    required int enfermedadTratamientoId,
    required String descripcion,
  }) : super(
            enfermedadTratamientoId: enfermedadTratamientoId,
            descripcion: descripcion);

  factory EnfermedadTratamientoModel.fromJson(Map<String, dynamic> json) =>
      EnfermedadTratamientoModel(
        enfermedadTratamientoId: json["EnfermedadTratamiento_id"],
        descripcion: json["Descripcion"],
      );
}
