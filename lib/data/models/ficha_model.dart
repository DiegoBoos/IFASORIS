import 'dart:convert';

import 'package:ifasoris/domain/entities/ficha_entity.dart';

FichaModel fichaModelFromJson(String str) =>
    FichaModel.fromJson(json.decode(str));

class FichaModel extends FichaEntity {
  FichaModel({
    required int fichaId,
    DateTime? fechaCreacion,
    required String numFicha,
    required String userName,
    DateTime? ultimaActualizacion,
  }) : super(
          fichaId: fichaId,
          fechaCreacion: fechaCreacion,
          numFicha: numFicha,
          userName: userName,
          ultimaActualizacion: ultimaActualizacion,
        );

  factory FichaModel.fromJson(Map<String, dynamic> json) => FichaModel(
        fichaId: json["Ficha_id"],
        fechaCreacion: DateTime.parse(json["FechaCreacion"]),
        numFicha: json["NumFicha"],
        userName: json["UserName"],
        ultimaActualizacion: DateTime.parse(json["UltimaActualizacion"]),
      );
}
