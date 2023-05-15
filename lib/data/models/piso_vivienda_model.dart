import 'dart:convert';

import '../../domain/entities/piso_vivienda_entity.dart';

List<PisoViviendaModel> pisosViviendaFromJson(String str) =>
    List<PisoViviendaModel>.from(
        json.decode(str).map((x) => PisoViviendaModel.fromJson(x)));

class PisoViviendaModel extends PisoViviendaEntity {
  PisoViviendaModel({
    required int pisoViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          pisoViviendaId: pisoViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory PisoViviendaModel.fromJson(Map<String, dynamic> json) =>
      PisoViviendaModel(
        pisoViviendaId: json["PisoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
