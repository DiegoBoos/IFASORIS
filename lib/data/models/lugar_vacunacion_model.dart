import 'dart:convert';

import 'package:ifasoris/domain/entities/lugar_vacunacion_entity.dart';

List<LugarVacunacionModel> lugaresVacunacionFromJson(String str) =>
    List<LugarVacunacionModel>.from(
        json.decode(str).map((x) => LugarVacunacionModel.fromJson(x)));

class LugarVacunacionModel extends LugarVacunacionEntity {
  LugarVacunacionModel({
    required int lugarVacunacionId,
    required String descripcion,
  }) : super(lugarVacunacionId: lugarVacunacionId, descripcion: descripcion);

  factory LugarVacunacionModel.fromJson(Map<String, dynamic> json) =>
      LugarVacunacionModel(
        lugarVacunacionId: json["LugarVacunacion_id"],
        descripcion: json["Descripcion"],
      );
}
