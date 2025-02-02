import 'dart:convert';

import '../../domain/entities/alimentacion.dart';

List<AlimentacionModel> alimentacionesFromJson(String str) =>
    List<AlimentacionModel>.from(
        json.decode(str).map((x) => AlimentacionModel.fromJson(x)));

class AlimentacionModel extends AlimentacionEntity {
  const AlimentacionModel({
    super.alimentacionId,
    super.descripcion,
  });

  factory AlimentacionModel.fromEntity(AlimentacionEntity alimentacion) {
    return AlimentacionModel(
      alimentacionId: alimentacion.alimentacionId,
      descripcion: alimentacion.descripcion,
    );
  }

  factory AlimentacionModel.fromJson(Map<String, dynamic> json) =>
      AlimentacionModel(
        alimentacionId: json["Alimentacion_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Alimentacion_id": alimentacionId,
        "Descripcion": descripcion,
      };
}
