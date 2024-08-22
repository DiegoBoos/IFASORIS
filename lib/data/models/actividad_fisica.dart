import 'dart:convert';

import 'package:ifasoris/domain/entities/actividad_fisica.dart';

List<ActividadFisicaModel> actividadesFisicasFromJson(String str) =>
    List<ActividadFisicaModel>.from(
        json.decode(str).map((x) => ActividadFisicaModel.fromJson(x)));

class ActividadFisicaModel extends ActividadFisicaEntity {
  const ActividadFisicaModel({
    int? actividadFisicaId,
    String? descripcion,
  }) : super(
          actividadFisicaId: actividadFisicaId,
          descripcion: descripcion,
        );

  static fromEntity(ActividadFisicaEntity actividadFisica) {
    return ActividadFisicaModel(
      actividadFisicaId: actividadFisica.actividadFisicaId,
      descripcion: actividadFisica.descripcion,
    );
  }

  factory ActividadFisicaModel.fromJson(Map<String, dynamic> json) =>
      ActividadFisicaModel(
        actividadFisicaId: json["ActividadFisica_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "ActividadFisica_id": actividadFisicaId,
        "Descripcion": descripcion,
      };
}
