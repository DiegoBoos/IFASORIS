import 'dart:convert';

import '../../domain/entities/grupo_riesgo.dart';

List<GrupoRiesgoModel> gruposRiesgoFromJson(String str) =>
    List<GrupoRiesgoModel>.from(
        json.decode(str).map((x) => GrupoRiesgoModel.fromJson(x)));

class GrupoRiesgoModel extends GrupoRiesgoEntity {
  const GrupoRiesgoModel({
    super.grupoRiesgoId,
    super.descripcion,
  });

  factory GrupoRiesgoModel.fromEntity(GrupoRiesgoEntity entity) {
    return GrupoRiesgoModel(
      grupoRiesgoId: entity.grupoRiesgoId,
      descripcion: entity.descripcion,
    );
  }

  factory GrupoRiesgoModel.fromJson(Map<String, dynamic> json) =>
      GrupoRiesgoModel(
        grupoRiesgoId: json["GrupoRiesgo_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "GrupoRiesgo_id": grupoRiesgoId,
        "Descripcion": descripcion,
      };
}
