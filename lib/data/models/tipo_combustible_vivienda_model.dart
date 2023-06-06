import 'dart:convert';

import '../../domain/entities/tipo_combustible_vivienda_entity.dart';

List<TipoCombustibleViviendaModel> tiposCombustibleViviendaFromJson(
        String str) =>
    List<TipoCombustibleViviendaModel>.from(
        json.decode(str).map((x) => TipoCombustibleViviendaModel.fromJson(x)));

class TipoCombustibleViviendaModel extends TipoCombustibleViviendaEntity {
  TipoCombustibleViviendaModel({
    required int tipoCombustibleViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          tipoCombustibleViviendaId: tipoCombustibleViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TipoCombustibleViviendaModel.fromJson(Map<String, dynamic> json) =>
      TipoCombustibleViviendaModel(
        tipoCombustibleViviendaId: json["TipoCombustibleVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstTiposCombustible {
  int? tipoCombustibleViviendaId;
  String? otroTipoCombustible;

  LstTiposCombustible({
    this.tipoCombustibleViviendaId,
    this.otroTipoCombustible,
  });

  factory LstTiposCombustible.fromJson(Map<String, dynamic> json) =>
      LstTiposCombustible(
        tipoCombustibleViviendaId: json["TipoCombustibleVivienda_id"],
        otroTipoCombustible: json["OtroTipoCombustible"],
      );

  Map<String, dynamic> toJson() => {
        "TipoCombustibleVivienda_id": tipoCombustibleViviendaId,
        "OtroTipoCombustible": otroTipoCombustible,
      };
}

List<ViviendaTiposCombustible> viviendaTiposCombustibleFromJson(String str) =>
    List<ViviendaTiposCombustible>.from(
        json.decode(str).map((x) => ViviendaTiposCombustible.fromJson(x)));

class ViviendaTiposCombustible {
  int? viviendaTipoCombustibleId;
  int? datoViviendaId;
  int? tipoCombustibleViviendaId;
  String? otroTipoCombustible;

  ViviendaTiposCombustible({
    this.viviendaTipoCombustibleId,
    this.datoViviendaId,
    this.tipoCombustibleViviendaId,
    this.otroTipoCombustible,
  });

  factory ViviendaTiposCombustible.fromJson(Map<String, dynamic> json) =>
      ViviendaTiposCombustible(
        viviendaTipoCombustibleId: json["ViviendaTipoCombustible_id"],
        datoViviendaId: json["DatoVivienda_id"],
        tipoCombustibleViviendaId: json["TipoCombustibleVivienda_id"],
        otroTipoCombustible: json["OtroTipoCombustible"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "TipoCombustibleVivienda_id": tipoCombustibleViviendaId,
        "OtroTipoCombustible": otroTipoCombustible,
      };
}
