import 'dart:convert';

import 'package:ifasoris/domain/entities/costumbre_practica_entity.dart';

List<CostumbrePracticaModel> costumbresPracticanFromJson(String str) =>
    List<CostumbrePracticaModel>.from(
        json.decode(str).map((x) => CostumbrePracticaModel.fromJson(x)));

class CostumbrePracticaModel extends CostumbrePracticaEntity {
  CostumbrePracticaModel({
    required int costumbrePracticaId,
    required String descripcion,
  }) : super(
            costumbrePracticaId: costumbrePracticaId, descripcion: descripcion);

  factory CostumbrePracticaModel.fromJson(Map<String, dynamic> json) =>
      CostumbrePracticaModel(
        costumbrePracticaId: json["CostumbrePractica_id"],
        descripcion: json["Descripcion"],
      );
}
