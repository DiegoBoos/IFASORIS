import 'dart:convert';

import '../../domain/entities/regimen_entity.dart';

List<RegimenModel> regimenesFromJson(String str) => List<RegimenModel>.from(
    json.decode(str).map((x) => RegimenModel.fromJson(x)));

class RegimenModel extends RegimenEntity {
  RegimenModel({
    required int regimenId,
    required String descripcion,
  }) : super(
          regimenId: regimenId,
          descripcion: descripcion,
        );

  factory RegimenModel.fromJson(Map<String, dynamic> json) => RegimenModel(
        regimenId: json["Regimen_id"],
        descripcion: json["Descripcion"],
      );
}
