import 'dart:convert';

import '../../domain/entities/tipo_regimen.dart';

List<TipoRegimenModel> tiporegimenesFromJson(String str) =>
    List<TipoRegimenModel>.from(
        json.decode(str).map((x) => TipoRegimenModel.fromJson(x)));

class TipoRegimenModel extends TipoRegimenEntity {
  const TipoRegimenModel({
    int? regimenId,
    String? codigo,
    String? descripcion,
  }) : super(
          regimenId: regimenId,
          codigo: codigo,
          descripcion: descripcion,
        );

  static TipoRegimenModel fromEntity(TipoRegimenEntity entity) {
    return TipoRegimenModel(
      regimenId: entity.regimenId,
      codigo: entity.codigo,
      descripcion: entity.descripcion,
    );
  }

  factory TipoRegimenModel.fromJson(Map<String, dynamic> json) =>
      TipoRegimenModel(
        regimenId: json["Regimen_id"],
        descripcion: json["Descripcion"],
        codigo: json["Codigo"],
      );

  Map<String, dynamic> toJson() => {
        "Regimen_id": regimenId,
        "Descripcion": descripcion,
        "Codigo": codigo,
      };
}
