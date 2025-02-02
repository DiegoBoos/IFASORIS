import 'dart:convert';

import '../../domain/entities/factor_riesgo_vivienda.dart';

List<FactorRiesgoViviendaModel> factoresRiesgoViviendaFromJson(String str) =>
    List<FactorRiesgoViviendaModel>.from(
        json.decode(str).map((x) => FactorRiesgoViviendaModel.fromJson(x)));

class FactorRiesgoViviendaModel extends FactorRiesgoViviendaEntity {
  const FactorRiesgoViviendaModel({
    super.factorRiesgoViviendaId,
    super.descripcion,
    super.departamentoIde,
  });

  factory FactorRiesgoViviendaModel.fromEntity(
      FactorRiesgoViviendaEntity entity) {
    return FactorRiesgoViviendaModel(
      factorRiesgoViviendaId: entity.factorRiesgoViviendaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory FactorRiesgoViviendaModel.fromJson(Map<String, dynamic> json) =>
      FactorRiesgoViviendaModel(
        factorRiesgoViviendaId: json["FactorRiesgoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "FactorRiesgoVivienda_id": factorRiesgoViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstFactorRiesgo {
  int? viviendaId;
  int? factorRiesgoViviendaId;
  String? otroFactorRiesgo;

  LstFactorRiesgo({
    this.viviendaId,
    this.factorRiesgoViviendaId,
    this.otroFactorRiesgo,
  });

  factory LstFactorRiesgo.fromJson(Map<String, dynamic> json) =>
      LstFactorRiesgo(
        factorRiesgoViviendaId: json["FactorRiesgoVivienda_id"],
        otroFactorRiesgo: json["OtroFactorRiesgo"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": viviendaId,
        "FactorRiesgoVivienda_id": factorRiesgoViviendaId,
        "OtroFactorRiesgo": otroFactorRiesgo,
      };
}

List<ViviendaFactoresRiesgo> viviendaFactoresRiesgoFromJson(String str) =>
    List<ViviendaFactoresRiesgo>.from(
        json.decode(str).map((x) => ViviendaFactoresRiesgo.fromJson(x)));

class ViviendaFactoresRiesgo {
  int? viviendaFactorRiesgoId;
  int? datoViviendaId;
  int? factorRiesgoViviendaId;
  String? otroFactorRiesgo;

  ViviendaFactoresRiesgo({
    this.viviendaFactorRiesgoId,
    this.datoViviendaId,
    this.factorRiesgoViviendaId,
    this.otroFactorRiesgo,
  });

  factory ViviendaFactoresRiesgo.fromJson(Map<String, dynamic> json) =>
      ViviendaFactoresRiesgo(
        viviendaFactorRiesgoId: json["ViviendaFactorRiesgo_id"],
        datoViviendaId: json["DatoVivienda_id"],
        factorRiesgoViviendaId: json["FactorRiesgoVivienda_id"],
        otroFactorRiesgo: json["OtroFactorRiesgo"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "FactorRiesgoVivienda_id": factorRiesgoViviendaId,
        "OtroFactorRiesgo": otroFactorRiesgo,
      };
}
