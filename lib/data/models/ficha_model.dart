import 'dart:convert';

import 'package:ifasoris/domain/entities/ficha_entity.dart';

FichaModel fichaFromJson(String str) => FichaModel.fromJson(json.decode(str));

class FichaModel extends FichaEntity {
  FichaModel({
    required int fichaId,
    DateTime? fechaCreacion,
    required String numFicha,
    required String userNameCreacion,
    required String userNameActualizacion,
    DateTime? ultimaActualizacion,
  }) : super(
          fichaId: fichaId,
          fechaCreacion: fechaCreacion,
          numFicha: numFicha,
          userNameCreacion: userNameCreacion,
          userNameActualizacion: userNameActualizacion,
          ultimaActualizacion: ultimaActualizacion,
        );

  factory FichaModel.fromJson(Map<String, dynamic> json) => FichaModel(
        fichaId: json["Ficha_id"],
        fechaCreacion: DateTime.parse(json["FechaCreacion"]),
        numFicha: json["NumFicha"],
        userNameCreacion: json["UserName_Creacion"],
        userNameActualizacion: json["UserName_Actualizacion"],
        ultimaActualizacion: DateTime.parse(json["UltimaActualizacion"]),
      );
}
