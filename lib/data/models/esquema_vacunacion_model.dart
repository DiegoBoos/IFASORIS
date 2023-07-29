import 'dart:convert';

import 'package:ifasoris/domain/entities/esquema_vacunacion_entity.dart';

List<EsquemaVacunacionModel> esquemasVacunacionFromJson(String str) =>
    List<EsquemaVacunacionModel>.from(
        json.decode(str).map((x) => EsquemaVacunacionModel.fromJson(x)));

class EsquemaVacunacionModel extends EsquemaVacunacionEntity {
  EsquemaVacunacionModel({
    required int esquemaVacunacionId,
    required String descripcion,
  }) : super(
            esquemaVacunacionId: esquemaVacunacionId, descripcion: descripcion);

  factory EsquemaVacunacionModel.fromJson(Map<String, dynamic> json) =>
      EsquemaVacunacionModel(
        esquemaVacunacionId: json["EsquemaVacunacion_id"],
        descripcion: json["Descripcion"],
      );
}
