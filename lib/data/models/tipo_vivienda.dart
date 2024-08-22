import 'dart:convert';

import '../../domain/entities/tipo_vivienda.dart';

List<TipoViviendaModel> tiposViviendaFromJson(String str) =>
    List<TipoViviendaModel>.from(
        json.decode(str).map((x) => TipoViviendaModel.fromJson(x)));

class TipoViviendaModel extends TipoViviendaEntity {
  const TipoViviendaModel({
    int? tipoViviendaId,
    String? descripcion,
    int? departamentoIde,
  }) : super(
          tipoViviendaId: tipoViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  static TipoViviendaModel fromEntity(TipoViviendaEntity entity) {
    return TipoViviendaModel(
      tipoViviendaId: entity.tipoViviendaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory TipoViviendaModel.fromJson(Map<String, dynamic> json) =>
      TipoViviendaModel(
        tipoViviendaId: json["TipoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "TipoVivienda_id": tipoViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
