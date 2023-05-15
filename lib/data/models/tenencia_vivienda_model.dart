import 'dart:convert';

import '../../domain/entities/tenencia_vivienda_entity.dart';

List<TenenciaViviendaModel> tenenciasViviendaFromJson(String str) =>
    List<TenenciaViviendaModel>.from(
        json.decode(str).map((x) => TenenciaViviendaModel.fromJson(x)));

class TenenciaViviendaModel extends TenenciaViviendaEntity {
  TenenciaViviendaModel({
    required int tenenciaViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          tenenciaViviendaId: tenenciaViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TenenciaViviendaModel.fromJson(Map<String, dynamic> json) =>
      TenenciaViviendaModel(
        tenenciaViviendaId: json["TenenciaVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
