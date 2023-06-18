import 'dart:convert';

import '../../domain/entities/grupo_riesgo_entity.dart';

List<GrupoRiesgoModel> gruposRiesgoFromJson(String str) =>
    List<GrupoRiesgoModel>.from(
        json.decode(str).map((x) => GrupoRiesgoModel.fromJson(x)));

class GrupoRiesgoModel extends GrupoRiesgoEntity {
  GrupoRiesgoModel({
    required int grupoRiesgoId,
    required String descripcion,
  }) : super(
          grupoRiesgoId: grupoRiesgoId,
          descripcion: descripcion,
        );

  factory GrupoRiesgoModel.fromJson(Map<String, dynamic> json) =>
      GrupoRiesgoModel(
        grupoRiesgoId: json["GrupoRiesgo_id"],
        descripcion: json["Descripcion"],
      );
}
