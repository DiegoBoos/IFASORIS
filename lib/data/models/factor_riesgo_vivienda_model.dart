import 'dart:convert';

import '../../domain/entities/factor_riesgo_vivienda_entity.dart';

List<FactorRiesgoViviendaModel> factoresRiesgoViviendaFromJson(String str) =>
    List<FactorRiesgoViviendaModel>.from(
        json.decode(str).map((x) => FactorRiesgoViviendaModel.fromJson(x)));

class FactorRiesgoViviendaModel extends FactorRiesgoViviendaEntity {
  FactorRiesgoViviendaModel({
    required int factorRiesgoViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          factorRiesgoViviendaId: factorRiesgoViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory FactorRiesgoViviendaModel.fromJson(Map<String, dynamic> json) =>
      FactorRiesgoViviendaModel(
        factorRiesgoViviendaId: json["FactorRiesgoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstFactoresRiesgo {
  int? factorRiesgoViviendaId;

  LstFactoresRiesgo({
    this.factorRiesgoViviendaId,
  });

  factory LstFactoresRiesgo.fromJson(Map<String, dynamic> json) =>
      LstFactoresRiesgo(
        factorRiesgoViviendaId: json["FactorRiesgoVivienda_id"],
      );

  Map<String, dynamic> toJson() => {
        "FactorRiesgoVivienda_id": factorRiesgoViviendaId,
      };
}

List<ViviendaFactoresRiesgo> viviendaFactoresRiesgoFromJson(String str) =>
    List<ViviendaFactoresRiesgo>.from(
        json.decode(str).map((x) => ViviendaFactoresRiesgo.fromJson(x)));

class ViviendaFactoresRiesgo {
  int? viviendaFactorRiesgoId;
  int? datoViviendaId;
  int? factorRiesgoViviendaId;

  ViviendaFactoresRiesgo({
    this.viviendaFactorRiesgoId,
    this.datoViviendaId,
    this.factorRiesgoViviendaId,
  });

  factory ViviendaFactoresRiesgo.fromJson(Map<String, dynamic> json) =>
      ViviendaFactoresRiesgo(
        viviendaFactorRiesgoId: json["ViviendaFactorRiesgo_id"],
        datoViviendaId: json["DatoVivienda_id"],
        factorRiesgoViviendaId: json["FactorRiesgoVivienda_id"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "FactorRiesgoVivienda_id": factorRiesgoViviendaId,
      };
}
