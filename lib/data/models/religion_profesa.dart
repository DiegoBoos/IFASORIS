import 'dart:convert';

import 'package:ifasoris/domain/entities/religion_profesa.dart';

List<ReligionProfesaModel> religionesProfesaFromJson(String str) =>
    List<ReligionProfesaModel>.from(
        json.decode(str).map((x) => ReligionProfesaModel.fromJson(x)));

class ReligionProfesaModel extends ReligionProfesaEntity {
  const ReligionProfesaModel({
    int? religionProfesaId,
    String? descripcion,
  });

  static ReligionProfesaModel fromEntity(ReligionProfesaEntity entity) {
    return ReligionProfesaModel(
      religionProfesaId: entity.religionProfesaId,
      descripcion: entity.descripcion,
    );
  }

  factory ReligionProfesaModel.fromJson(Map<String, dynamic> json) =>
      ReligionProfesaModel(
        religionProfesaId: json["ReligionProfesa_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "ReligionProfesa_id": religionProfesaId,
        "Descripcion": descripcion,
      };
}
