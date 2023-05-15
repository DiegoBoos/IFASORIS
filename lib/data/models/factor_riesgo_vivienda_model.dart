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
