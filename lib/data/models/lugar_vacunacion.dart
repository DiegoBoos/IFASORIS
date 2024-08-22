import 'dart:convert';

import 'package:ifasoris/domain/entities/lugar_vacunacion.dart';

List<LugarVacunacionModel> lugaresVacunacionFromJson(String str) =>
    List<LugarVacunacionModel>.from(
        json.decode(str).map((x) => LugarVacunacionModel.fromJson(x)));

class LugarVacunacionModel extends LugarVacunacionEntity {
  const LugarVacunacionModel({
    int? lugarVacunacionId,
    String? descripcion,
  }) : super(
          lugarVacunacionId: lugarVacunacionId,
          descripcion: descripcion,
        );

  static LugarVacunacionModel fromEntity(LugarVacunacionEntity entity) {
    return LugarVacunacionModel(
      lugarVacunacionId: entity.lugarVacunacionId,
      descripcion: entity.descripcion,
    );
  }

  factory LugarVacunacionModel.fromJson(Map<String, dynamic> json) =>
      LugarVacunacionModel(
        lugarVacunacionId: json["LugarVacunacion_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "LugarVacunacion_id": lugarVacunacionId,
        "Descripcion": descripcion,
      };
}
