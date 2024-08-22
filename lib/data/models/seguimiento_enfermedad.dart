import 'dart:convert';

import 'package:ifasoris/domain/entities/seguimiento_enfermedad.dart';

List<SeguimientoEnfermedadModel> seguimientoEnfermedadesFromJson(String str) =>
    List<SeguimientoEnfermedadModel>.from(
        json.decode(str).map((x) => SeguimientoEnfermedadModel.fromJson(x)));

class SeguimientoEnfermedadModel extends SeguimientoEnfermedadEntity {
  const SeguimientoEnfermedadModel({
    int? seguimientoEnfermedadId,
    String? descripcion,
  }) : super(
          seguimientoEnfermedadId: seguimientoEnfermedadId,
          descripcion: descripcion,
        );

  static SeguimientoEnfermedadModel fromEntity(
      SeguimientoEnfermedadEntity entity) {
    return SeguimientoEnfermedadModel(
      seguimientoEnfermedadId: entity.seguimientoEnfermedadId,
      descripcion: entity.descripcion,
    );
  }

  factory SeguimientoEnfermedadModel.fromJson(Map<String, dynamic> json) =>
      SeguimientoEnfermedadModel(
        seguimientoEnfermedadId: json["SeguimientoEnfermedad_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "SeguimientoEnfermedad_id": seguimientoEnfermedadId,
        "Descripcion": descripcion,
      };
}
