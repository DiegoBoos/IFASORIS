import 'dart:convert';

import 'package:ifasoris/domain/entities/cigarrillo_dia.dart';

List<CigarrilloDiaModel> cigarrillosDiaFromJson(String str) =>
    List<CigarrilloDiaModel>.from(
        json.decode(str).map((x) => CigarrilloDiaModel.fromJson(x)));

class CigarrilloDiaModel extends CigarrilloDiaEntity {
  const CigarrilloDiaModel({
    int? numeroCigarrilloDiaId,
    String? descripcion,
  }) : super(
          numeroCigarrilloDiaId: numeroCigarrilloDiaId,
          descripcion: descripcion,
        );

  static CigarrilloDiaModel fromEntity(CigarrilloDiaEntity entity) {
    return CigarrilloDiaModel(
      numeroCigarrilloDiaId: entity.numeroCigarrilloDiaId,
      descripcion: entity.descripcion,
    );
  }

  factory CigarrilloDiaModel.fromJson(Map<String, dynamic> json) =>
      CigarrilloDiaModel(
        numeroCigarrilloDiaId: json["NumeroCigarrilloDia_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "NumeroCigarrilloDia_id": numeroCigarrilloDiaId,
        "Descripcion": descripcion,
      };
}
