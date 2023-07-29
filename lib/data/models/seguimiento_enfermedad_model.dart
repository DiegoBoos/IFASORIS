import 'dart:convert';

import 'package:ifasoris/domain/entities/seguimiento_enfermedad_entity.dart';

List<SeguimientoEnfermedadModel> seguimientoEnfermedadesFromJson(String str) =>
    List<SeguimientoEnfermedadModel>.from(
        json.decode(str).map((x) => SeguimientoEnfermedadModel.fromJson(x)));

class SeguimientoEnfermedadModel extends SeguimientoEnfermedadEntity {
  SeguimientoEnfermedadModel({
    required int seguimientoEnfermedadId,
    required String descripcion,
  }) : super(
            seguimientoEnfermedadId: seguimientoEnfermedadId,
            descripcion: descripcion);

  factory SeguimientoEnfermedadModel.fromJson(Map<String, dynamic> json) =>
      SeguimientoEnfermedadModel(
        seguimientoEnfermedadId: json["SeguimientoEnfermedad_id"],
        descripcion: json["Descripcion"],
      );
}
