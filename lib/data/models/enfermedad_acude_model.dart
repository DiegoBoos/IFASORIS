import 'dart:convert';

import 'package:ifasoris/domain/entities/enfermedad_acude_entity.dart';

List<EnfermedadAcudeModel> enfermedadesAcudeFromJson(String str) =>
    List<EnfermedadAcudeModel>.from(
        json.decode(str).map((x) => EnfermedadAcudeModel.fromJson(x)));

class EnfermedadAcudeModel extends EnfermedadAcudeEntity {
  EnfermedadAcudeModel({
    required int enfermedadAcudeId,
    required String descripcion,
  }) : super(enfermedadAcudeId: enfermedadAcudeId, descripcion: descripcion);

  factory EnfermedadAcudeModel.fromJson(Map<String, dynamic> json) =>
      EnfermedadAcudeModel(
        enfermedadAcudeId: json["EnfermedadAcude_id"],
        descripcion: json["Descripcion"],
      );
}
