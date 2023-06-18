import 'dart:convert';

import '../../domain/entities/grupo_familiar_entity.dart';

GrupoFamiliarModel grupoFamiliarFromJson(String str) =>
    GrupoFamiliarModel.fromJson(json.decode(str));

class GrupoFamiliarModel extends GrupoFamiliarEntity {
  GrupoFamiliarModel({
    int? afiliadoId,
    bool? isCompleted,
  }) : super(afiliadoId: afiliadoId, isCompleted: isCompleted);

  factory GrupoFamiliarModel.fromJson(Map<String, dynamic> json) =>
      GrupoFamiliarModel(
        afiliadoId: json["Afiliado_id"],
        isCompleted: json["isCompleted"],
      );
}
