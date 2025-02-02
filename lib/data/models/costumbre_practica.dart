import 'dart:convert';

import 'package:ifasoris/domain/entities/costumbre_practica.dart';

List<CostumbrePracticaModel> costumbresPracticanFromJson(String str) =>
    List<CostumbrePracticaModel>.from(
        json.decode(str).map((x) => CostumbrePracticaModel.fromJson(x)));

class CostumbrePracticaModel extends CostumbrePracticaEntity {
  const CostumbrePracticaModel({
    super.costumbrePracticaId,
    super.descripcion,
  });

  factory CostumbrePracticaModel.fromEntity(CostumbrePracticaEntity entity) {
    return CostumbrePracticaModel(
      costumbrePracticaId: entity.costumbrePracticaId,
      descripcion: entity.descripcion,
    );
  }

  factory CostumbrePracticaModel.fromJson(Map<String, dynamic> json) =>
      CostumbrePracticaModel(
        costumbrePracticaId: json["CostumbrePractica_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "CostumbrePractica_id": costumbrePracticaId,
        "Descripcion": descripcion,
      };
}
