import 'dart:convert';

import 'package:ifasoris/domain/entities/actividad_fisica_entity.dart';

List<ActividadFisicaModel> actividadesFisicasFromJson(String str) =>
    List<ActividadFisicaModel>.from(
        json.decode(str).map((x) => ActividadFisicaModel.fromJson(x)));

class ActividadFisicaModel extends ActividadFisicaEntity {
  ActividadFisicaModel({
    required int actividadFisicaId,
    required String descripcion,
  }) : super(actividadFisicaId: actividadFisicaId, descripcion: descripcion);

  factory ActividadFisicaModel.fromJson(Map<String, dynamic> json) =>
      ActividadFisicaModel(
        actividadFisicaId: json["ActividadFisica_id"],
        descripcion: json["Descripcion"],
      );
}
