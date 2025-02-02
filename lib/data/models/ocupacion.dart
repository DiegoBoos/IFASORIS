import 'dart:convert';

import '../../domain/entities/ocupacion.dart';

List<OcupacionModel> ocupacionesFromJson(String str) =>
    List<OcupacionModel>.from(
        json.decode(str).map((x) => OcupacionModel.fromJson(x)));

class OcupacionModel extends OcupacionEntity {
  const OcupacionModel({
    super.ocupacionId,
    super.descripcion,
  });

  factory OcupacionModel.fromEntity(OcupacionEntity entity) {
    return OcupacionModel(
      ocupacionId: entity.ocupacionId,
      descripcion: entity.descripcion,
    );
  }

  factory OcupacionModel.fromJson(Map<String, dynamic> json) => OcupacionModel(
        ocupacionId: json["Ocupacion_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Ocupacion_id": ocupacionId,
        "Descripcion": descripcion,
      };
}
