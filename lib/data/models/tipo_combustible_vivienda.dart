import 'dart:convert';

import '../../domain/entities/tipo_combustible_vivienda.dart';

List<TipoCombustibleViviendaModel> tiposCombustibleViviendaFromJson(
        String str) =>
    List<TipoCombustibleViviendaModel>.from(
        json.decode(str).map((x) => TipoCombustibleViviendaModel.fromJson(x)));

class TipoCombustibleViviendaModel extends TipoCombustibleViviendaEntity {
  const TipoCombustibleViviendaModel({
    int? tipoCombustibleViviendaId,
    String? descripcion,
    int? departamentoIde,
  }) : super(
          tipoCombustibleViviendaId: tipoCombustibleViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  static TipoCombustibleViviendaModel fromEntity(
      TipoCombustibleViviendaEntity entity) {
    return TipoCombustibleViviendaModel(
      tipoCombustibleViviendaId: entity.tipoCombustibleViviendaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory TipoCombustibleViviendaModel.fromJson(Map<String, dynamic> json) =>
      TipoCombustibleViviendaModel(
        tipoCombustibleViviendaId: json["TipoCombustibleVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "TipoCombustibleVivienda_id": tipoCombustibleViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstTipoCombustible {
  int? viviendaId;
  int? tipoCombustibleViviendaId;
  String? otroTipoCombustible;

  LstTipoCombustible({
    this.viviendaId,
    this.tipoCombustibleViviendaId,
    this.otroTipoCombustible,
  });

  factory LstTipoCombustible.fromJson(Map<String, dynamic> json) =>
      LstTipoCombustible(
        tipoCombustibleViviendaId: json["TipoCombustibleVivienda_id"],
        otroTipoCombustible: json["OtroTipoCombustible"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": viviendaId,
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
