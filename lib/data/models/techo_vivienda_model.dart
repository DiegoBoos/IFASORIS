import 'dart:convert';

import '../../domain/entities/techo_vivienda_entity.dart';

List<TechoViviendaModel> techosViviendaFromJson(String str) =>
    List<TechoViviendaModel>.from(
        json.decode(str).map((x) => TechoViviendaModel.fromJson(x)));

class TechoViviendaModel extends TechoViviendaEntity {
  TechoViviendaModel({
    required int techoViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          techoViviendaId: techoViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TechoViviendaModel.fromJson(Map<String, dynamic> json) =>
      TechoViviendaModel(
        techoViviendaId: json["TechoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
