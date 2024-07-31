import 'dart:convert';

import 'package:ifasoris/domain/entities/esquema_vacunacion.dart';

List<EsquemaVacunacionModel> esquemasVacunacionFromJson(String str) =>
    List<EsquemaVacunacionModel>.from(
        json.decode(str).map((x) => EsquemaVacunacionModel.fromJson(x)));

class EsquemaVacunacionModel extends EsquemaVacunacionEntity {
  const EsquemaVacunacionModel({
    int? esquemaVacunacionId,
    String? descripcion,
  });

  static EsquemaVacunacionModel fromEntity(EsquemaVacunacionEntity entity) {
    return EsquemaVacunacionModel(
      esquemaVacunacionId: entity.esquemaVacunacionId,
      descripcion: entity.descripcion,
    );
  }

  factory EsquemaVacunacionModel.fromJson(Map<String, dynamic> json) =>
      EsquemaVacunacionModel(
        esquemaVacunacionId: json["EsquemaVacunacion_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "EsquemaVacunacion_id": esquemaVacunacionId,
        "Descripcion": descripcion,
      };
}
