import 'dart:convert';

import 'package:ifasoris/data/models/familia.dart';
import 'package:ifasoris/domain/entities/ficha.dart';

FichaModel fichaFromJson(String str) => FichaModel.fromJson(json.decode(str));
List<FichaModel> fichasFromJson(String str) =>
    List<FichaModel>.from(json.decode(str).map((x) => FichaModel.fromJson(x)));

class FichaModel extends FichaEntity {
  const FichaModel({
    int? fichaId,
    DateTime? fechaCreacion,
    String? numFicha,
    String? userNameCreacion,
    String? userNameActualizacion,
    DateTime? ultimaActualizacion,
    int? fichaIdRemote,
    FamiliaModel? familia,
  }) : super(
          fichaId: fichaId,
          fechaCreacion: fechaCreacion,
          numFicha: numFicha,
          userNameCreacion: userNameCreacion,
          userNameActualizacion: userNameActualizacion,
          ultimaActualizacion: ultimaActualizacion,
          fichaIdRemote: fichaIdRemote,
          familia: familia,
        );

  static FichaModel fromEntity(FichaEntity entity) {
    return FichaModel(
      fichaId: entity.fichaId,
      fechaCreacion: entity.fechaCreacion,
      numFicha: entity.numFicha,
      userNameCreacion: entity.userNameCreacion,
      userNameActualizacion: entity.userNameActualizacion,
      ultimaActualizacion: entity.ultimaActualizacion,
      fichaIdRemote: entity.fichaIdRemote,
      familia: (entity.familia != null)
          ? FamiliaModel.fromEntity(entity.familia!)
          : null,
    );
  }

  factory FichaModel.fromJson(Map<String, dynamic> json) => FichaModel(
        fichaId: json["Ficha_id"],
        fechaCreacion: json["FechaCreacion"] != null
            ? DateTime.parse(json["FechaCreacion"])
            : null,
        numFicha: json["NumFicha"],
        userNameCreacion: json["UserName_Creacion"],
        userNameActualizacion: json["UserName_Actualizacion"],
        fichaIdRemote: json["Ficha_id_remote"],
        ultimaActualizacion: json["UltimaActualizacion"] != null
            ? DateTime.parse(json["UltimaActualizacion"])
            : null,
        familia: (json["familia"] != null)
            ? FamiliaModel.fromJson(json["familia"])
            : null,
      );

  FichaModel copyWith({
    int? fichaId,
    DateTime? fechaCreacion,
    String? numFicha,
    String? userNameCreacion,
    String? userNameActualizacion,
    DateTime? ultimaActualizacion,
    int? fichaIdRemote,
    FamiliaModel? familia,
  }) {
    return FichaModel(
      fichaId: fichaId ?? this.fichaId,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      numFicha: numFicha ?? this.numFicha,
      userNameCreacion: userNameCreacion ?? this.userNameCreacion,
      userNameActualizacion:
          userNameActualizacion ?? this.userNameActualizacion,
      ultimaActualizacion: ultimaActualizacion ?? this.ultimaActualizacion,
      fichaIdRemote: fichaIdRemote ?? this.fichaIdRemote,
      familia: familia ?? this.familia,
    );
  }

  Map<String, dynamic> toJson() => {
        "Ficha_id": fichaId,
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName_Creacion": userNameCreacion,
        "UserName_Actualizacion": userNameActualizacion,
        "Ficha_id_remote": fichaIdRemote,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
        "familia": familia
      };

  Map<String, dynamic> toJsonLocalCompleta() => {
        "Ficha_id_remote": fichaId,
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName_Creacion": userNameCreacion,
        "UserName_Actualizacion": userNameActualizacion,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
        "familia": familia,
      };

  Map<String, dynamic> toJsonLocal() => {
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName_Creacion": userNameCreacion,
        "UserName_Actualizacion": userNameActualizacion,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
        "Ficha_id_remote": fichaIdRemote,
      };

  Map<String, dynamic> toJsonRemote() => {
        "Ficha_id": fichaId,
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName_Creacion": userNameCreacion,
        "UserName_Actualizacion": userNameActualizacion,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
      };
}
