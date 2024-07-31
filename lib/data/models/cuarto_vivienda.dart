import 'dart:convert';

import '../../domain/entities/cuarto_vivienda.dart';

List<CuartoViviendaModel> cuartosViviendaFromJson(String str) =>
    List<CuartoViviendaModel>.from(
        json.decode(str).map((x) => CuartoViviendaModel.fromJson(x)));

class CuartoViviendaModel extends CuartoViviendaEntity {
  const CuartoViviendaModel({
    int? cuartoViviendaId,
    String? descripcion,
  });

  static CuartoViviendaModel fromEntity(CuartoViviendaEntity entity) {
    return CuartoViviendaModel(
      cuartoViviendaId: entity.cuartoViviendaId,
      descripcion: entity.descripcion,
    );
  }

  factory CuartoViviendaModel.fromJson(Map<String, dynamic> json) =>
      CuartoViviendaModel(
        cuartoViviendaId: json["CuartosVivienda_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "CuartosVivienda_id": cuartoViviendaId,
        "Descripcion": descripcion,
      };
}
