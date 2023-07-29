import 'dart:convert';

import 'package:ifasoris/domain/entities/condicion_nutricional_entity.dart';

List<CondicionNutricionalModel> condicionesNutricionalesFromJson(String str) =>
    List<CondicionNutricionalModel>.from(
        json.decode(str).map((x) => CondicionNutricionalModel.fromJson(x)));

class CondicionNutricionalModel extends CondicionNutricionalEntity {
  CondicionNutricionalModel({
    required int condicionNutricionalId,
    required String descripcion,
  }) : super(
            condicionNutricionalId: condicionNutricionalId,
            descripcion: descripcion);

  factory CondicionNutricionalModel.fromJson(Map<String, dynamic> json) =>
      CondicionNutricionalModel(
        condicionNutricionalId: json["CondicionNutricional_id"],
        descripcion: json["Descripcion"],
      );
}
