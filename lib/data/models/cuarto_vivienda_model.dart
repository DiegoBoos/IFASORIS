import 'dart:convert';

import '../../domain/entities/cuarto_vivienda_entity.dart';

List<NroCuartoViviendaModel> nroCuartosViviendaFromJson(String str) =>
    List<NroCuartoViviendaModel>.from(
        json.decode(str).map((x) => NroCuartoViviendaModel.fromJson(x)));

class NroCuartoViviendaModel extends NroCuartoViviendaEntity {
  NroCuartoViviendaModel({
    required int nroCuartoViviendaId,
    required String descripcion,
  }) : super(
          nroCuartoViviendaId: nroCuartoViviendaId,
          descripcion: descripcion,
        );

  factory NroCuartoViviendaModel.fromJson(Map<String, dynamic> json) =>
      NroCuartoViviendaModel(
        nroCuartoViviendaId: json["NroCuartosVivienda_id"],
        descripcion: json["Descripcion"],
      );
}
