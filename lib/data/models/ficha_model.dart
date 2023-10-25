import 'dart:convert';

import 'package:ifasoris/domain/entities/familia_entity.dart';
import 'package:ifasoris/domain/entities/ficha_entity.dart';

FichaModel fichaFromJson(String str) => FichaModel.fromJson(json.decode(str));
List<FichaModel> fichasFromJson(String str) =>
    List<FichaModel>.from(json.decode(str).map((x) => FichaModel.fromJson(x)));

class FichaModel extends FichaEntity {
  FichaModel({
    required int fichaId,
    DateTime? fechaCreacion,
    required String numFicha,
    required String userNameCreacion,
    String? userNameActualizacion,
    DateTime? ultimaActualizacion,
    int? fichaIdRemote,
    FamiliaEntity? familia,
  }) : super(
            fichaId: fichaId,
            fechaCreacion: fechaCreacion,
            numFicha: numFicha,
            userNameCreacion: userNameCreacion,
            userNameActualizacion: userNameActualizacion,
            ultimaActualizacion: ultimaActualizacion,
            fichaIdRemote: fichaIdRemote,
            familia: familia);

  factory FichaModel.fromJson(Map<String, dynamic> json) => FichaModel(
        fichaId: json["Ficha_id"],
        fechaCreacion: DateTime.parse(json["FechaCreacion"]),
        numFicha: json["NumFicha"],
        userNameCreacion: json["UserName_Creacion"],
        userNameActualizacion: json["UserName_Actualizacion"],
        fichaIdRemote: json["Ficha_id_remote"],
        ultimaActualizacion: json["UltimaActualizacion"] != null
            ? DateTime.parse(json["UltimaActualizacion"])
            : null,
        familia: (json["familia"] != null)
            ? FamiliaEntity.fromJson(json["familia"])
            : null,
      );
}
