import 'dart:convert';

import '../../domain/entities/nivel_educativo.dart';

List<NivelEducativoModel> nivelesEducativosFromJson(String str) =>
    List<NivelEducativoModel>.from(
        json.decode(str).map((x) => NivelEducativoModel.fromJson(x)));

class NivelEducativoModel extends NivelEducativoEntity {
  const NivelEducativoModel({
    int? nivelEducativoId,
    String? descripcion,
  });

  static NivelEducativoModel fromEntity(NivelEducativoEntity entity) {
    return NivelEducativoModel(
      nivelEducativoId: entity.nivelEducativoId,
      descripcion: entity.descripcion,
    );
  }

  factory NivelEducativoModel.fromJson(Map<String, dynamic> json) =>
      NivelEducativoModel(
        nivelEducativoId: json["NivelEducativo_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "NivelEducativo_id": nivelEducativoId,
        "Descripcion": descripcion,
      };
}
