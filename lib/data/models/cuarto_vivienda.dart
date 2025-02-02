import 'dart:convert';

import '../../domain/entities/cuarto_vivienda.dart';

List<CuartoViviendaModel> cuartosViviendaFromJson(String str) =>
    List<CuartoViviendaModel>.from(
        json.decode(str).map((x) => CuartoViviendaModel.fromJson(x)));

class CuartoViviendaModel extends CuartoViviendaEntity {
  const CuartoViviendaModel({
    super.cuartoViviendaId,
    super.descripcion,
  });

  factory CuartoViviendaModel.fromEntity(CuartoViviendaEntity entity) {
    return CuartoViviendaModel(
      cuartoViviendaId: entity.cuartoViviendaId,
      descripcion: entity.descripcion,
    );
  }

  factory CuartoViviendaModel.fromJson(Map<String, dynamic> json) =>
      CuartoViviendaModel(
        cuartoViviendaId: json["NroCuartosVivienda_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "NroCuartosVivienda_id": cuartoViviendaId,
        "Descripcion": descripcion,
      };
}
