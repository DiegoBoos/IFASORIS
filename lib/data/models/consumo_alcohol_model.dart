import 'dart:convert';

import 'package:ifasoris/domain/entities/consumo_alcohol_entity.dart';

List<ConsumoAlcoholModel> consumosAlcoholFromJson(String str) =>
    List<ConsumoAlcoholModel>.from(
        json.decode(str).map((x) => ConsumoAlcoholModel.fromJson(x)));

class ConsumoAlcoholModel extends ConsumoAlcoholEntity {
  ConsumoAlcoholModel({
    required int consumoAlcoholId,
    required String descripcion,
  }) : super(consumoAlcoholId: consumoAlcoholId, descripcion: descripcion);

  factory ConsumoAlcoholModel.fromJson(Map<String, dynamic> json) =>
      ConsumoAlcoholModel(
        consumoAlcoholId: json["ConsumoAlcohol_id"],
        descripcion: json["Descripcion"],
      );
}
