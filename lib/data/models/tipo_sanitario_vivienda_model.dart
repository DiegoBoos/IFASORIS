import 'dart:convert';

import '../../domain/entities/tipo_sanitario_vivienda_entity.dart';

List<TipoSanitarioViviendaModel> tiposSanitarioViviendaFromJson(String str) =>
    List<TipoSanitarioViviendaModel>.from(
        json.decode(str).map((x) => TipoSanitarioViviendaModel.fromJson(x)));

class TipoSanitarioViviendaModel extends TipoSanitarioViviendaEntity {
  TipoSanitarioViviendaModel({
    required int tipoSanitarioViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          tipoSanitarioViviendaId: tipoSanitarioViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TipoSanitarioViviendaModel.fromJson(Map<String, dynamic> json) =>
      TipoSanitarioViviendaModel(
        tipoSanitarioViviendaId: json["TipoSanitarioVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
