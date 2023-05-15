import 'dart:convert';

import '../../domain/entities/tipo_vivienda_entity.dart';

List<TipoViviendaModel> tiposViviendaFromJson(String str) =>
    List<TipoViviendaModel>.from(
        json.decode(str).map((x) => TipoViviendaModel.fromJson(x)));

class TipoViviendaModel extends TipoViviendaEntity {
  TipoViviendaModel({
    required int tipoViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          tipoViviendaId: tipoViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TipoViviendaModel.fromJson(Map<String, dynamic> json) =>
      TipoViviendaModel(
        tipoViviendaId: json["TipoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
