import 'dart:convert';

import '../../domain/entities/tenencia_vivienda.dart';

List<TenenciaViviendaModel> tenenciasViviendaFromJson(String str) =>
    List<TenenciaViviendaModel>.from(
        json.decode(str).map((x) => TenenciaViviendaModel.fromJson(x)));

class TenenciaViviendaModel extends TenenciaViviendaEntity {
  const TenenciaViviendaModel({
    int? tenenciaViviendaId,
    String? descripcion,
    int? departamentoIde,
  });

  static TenenciaViviendaModel fromEntity(TenenciaViviendaEntity entity) {
    return TenenciaViviendaModel(
      tenenciaViviendaId: entity.tenenciaViviendaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory TenenciaViviendaModel.fromJson(Map<String, dynamic> json) =>
      TenenciaViviendaModel(
        tenenciaViviendaId: json["TenenciaVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "TenenciaVivienda_id": tenenciaViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
