import 'dart:convert';

import '../../domain/entities/regimen.dart';

List<RegimenModel> regimenesFromJson(String str) => List<RegimenModel>.from(
    json.decode(str).map((x) => RegimenModel.fromJson(x)));

class RegimenModel extends RegimenEntity {
  const RegimenModel({
    int? tipoRegimenId,
    String? tipo,
    String? descripcion,
  });

  static RegimenModel fromEntity(RegimenEntity entity) {
    return RegimenModel(
      tipoRegimenId: entity.tipoRegimenId,
      tipo: entity.tipo,
      descripcion: entity.descripcion,
    );
  }

  factory RegimenModel.fromJson(Map<String, dynamic> json) => RegimenModel(
        tipoRegimenId: json["Regimen_id"],
        tipo: json["Codigo"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Regimen_id": tipoRegimenId,
        "Codigo": tipo,
        "Descripcion": descripcion,
      };
}
