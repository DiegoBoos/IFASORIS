import 'dart:convert';

import 'package:ifasoris/domain/entities/ficha_entity.dart';

FichaModel fichaModelFromJson(String str) =>
    FichaModel.fromJson(json.decode(str));

class FichaModel extends FichaEntity {
  FichaModel({
    DateTime? fechaCreacion,
    String? numFicha,
    int? encuestadorId,
    String? userName,
    DateTime? ultimaActualizacion,
  }) : super(
          fechaCreacion: fechaCreacion,
          numFicha: numFicha ?? '',
          encuestadorId: encuestadorId ?? 0,
          userName: userName ?? '',
          ultimaActualizacion: ultimaActualizacion,
        );

  factory FichaModel.fromJson(Map<String, dynamic> json) => FichaModel(
        fechaCreacion: DateTime.parse(json["FechaCreacion"]),
        numFicha: json["NumFicha"],
        encuestadorId: json["Encuestador_id"],
        userName: json["UserName"],
        ultimaActualizacion: DateTime.parse(json["UltimaActualizacion"]),
      );
}
