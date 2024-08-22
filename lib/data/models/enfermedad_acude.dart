import 'dart:convert';

import 'package:ifasoris/domain/entities/enfermedad_acude.dart';

List<EnfermedadAcudeModel> enfermedadesAcudeFromJson(String str) =>
    List<EnfermedadAcudeModel>.from(
        json.decode(str).map((x) => EnfermedadAcudeModel.fromJson(x)));

class EnfermedadAcudeModel extends EnfermedadAcudeEntity {
  const EnfermedadAcudeModel({
    int? enfermedadAcudeId,
    String? descripcion,
  }) : super(
          enfermedadAcudeId: enfermedadAcudeId,
          descripcion: descripcion,
        );

  static EnfermedadAcudeModel fromEntity(EnfermedadAcudeEntity entity) {
    return EnfermedadAcudeModel(
      enfermedadAcudeId: entity.enfermedadAcudeId,
      descripcion: entity.descripcion,
    );
  }

  factory EnfermedadAcudeModel.fromJson(Map<String, dynamic> json) =>
      EnfermedadAcudeModel(
        enfermedadAcudeId: json["EnfermedadAcude_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "EnfermedadAcude_id": enfermedadAcudeId,
        "Descripcion": descripcion,
      };
}
