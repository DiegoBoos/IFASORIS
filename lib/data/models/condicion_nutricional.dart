import 'dart:convert';

import 'package:ifasoris/domain/entities/condicion_nutricional.dart';

List<CondicionNutricionalModel> condicionesNutricionalesFromJson(String str) =>
    List<CondicionNutricionalModel>.from(
        json.decode(str).map((x) => CondicionNutricionalModel.fromJson(x)));

class CondicionNutricionalModel extends CondicionNutricionalEntity {
  const CondicionNutricionalModel({
    int? condicionNutricionalId,
    String? descripcion,
  });

  static CondicionNutricionalModel fromEntity(
      CondicionNutricionalEntity entity) {
    return CondicionNutricionalModel(
      condicionNutricionalId: entity.condicionNutricionalId,
      descripcion: entity.descripcion,
    );
  }

  factory CondicionNutricionalModel.fromJson(Map<String, dynamic> json) =>
      CondicionNutricionalModel(
        condicionNutricionalId: json["CondicionNutricional_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "CondicionNutricional_id": condicionNutricionalId,
        "Descripcion": descripcion,
      };
}
