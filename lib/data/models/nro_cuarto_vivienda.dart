import 'dart:convert';

import '../../domain/entities/nro_cuarto_vivienda.dart';

List<NroCuartoViviendaModel> nroCuartosViviendaFromJson(String str) =>
    List<NroCuartoViviendaModel>.from(
        json.decode(str).map((x) => NroCuartoViviendaModel.fromJson(x)));

class NroCuartoViviendaModel extends NroCuartoViviendaEntity {
  const NroCuartoViviendaModel({
    int? nroCuartoViviendaId,
    String? descripcion,
  }) : super(
          nroCuartoViviendaId: nroCuartoViviendaId,
          descripcion: descripcion,
        );

  static NroCuartoViviendaModel fromEntity(NroCuartoViviendaEntity entity) {
    return NroCuartoViviendaModel(
      nroCuartoViviendaId: entity.nroCuartoViviendaId,
      descripcion: entity.descripcion,
    );
  }

  factory NroCuartoViviendaModel.fromJson(Map<String, dynamic> json) =>
      NroCuartoViviendaModel(
        nroCuartoViviendaId: json["NroCuartosVivienda_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "NroCuartosVivienda_id": nroCuartoViviendaId,
        "Descripcion": descripcion,
      };
}
