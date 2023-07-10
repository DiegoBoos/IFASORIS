import 'dart:convert';

import '../../domain/entities/regimen_entity.dart';

List<RegimenModel> regimenesFromJson(String str) => List<RegimenModel>.from(
    json.decode(str).map((x) => RegimenModel.fromJson(x)));

class RegimenModel extends RegimenEntity {
  RegimenModel({
    required int tipoRegimenId,
    required String tipo,
    required String descripcion,
  }) : super(
          tipoRegimenId: tipoRegimenId,
          tipo: tipo,
          descripcion: descripcion,
        );

  factory RegimenModel.fromJson(Map<String, dynamic> json) => RegimenModel(
        tipoRegimenId: json["Regimen_id"],
        tipo: json["Codigo"],
        descripcion: json["Descripcion"],
      );
}
