import 'dart:convert';

import 'package:ifasoris/domain/entities/consumo_alcohol.dart';

List<ConsumoAlcoholModel> consumosAlcoholFromJson(String str) =>
    List<ConsumoAlcoholModel>.from(
        json.decode(str).map((x) => ConsumoAlcoholModel.fromJson(x)));

class ConsumoAlcoholModel extends ConsumoAlcoholEntity {
  const ConsumoAlcoholModel({
    super.consumoAlcoholId,
    super.descripcion,
  });

  factory ConsumoAlcoholModel.fromEntity(ConsumoAlcoholEntity entity) {
    return ConsumoAlcoholModel(
      consumoAlcoholId: entity.consumoAlcoholId,
      descripcion: entity.descripcion,
    );
  }

  factory ConsumoAlcoholModel.fromJson(Map<String, dynamic> json) =>
      ConsumoAlcoholModel(
        consumoAlcoholId: json["ConsumoAlcohol_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "ConsumoAlcohol_id": consumoAlcoholId,
        "Descripcion": descripcion,
      };
}
