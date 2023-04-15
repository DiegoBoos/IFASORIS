import 'dart:convert';

import '../../domain/entities/medio_utiliza_ca_entity.dart';

List<MedioUtilizaCAModel> mediosUtilizaCAModelFromJson(String str) =>
    List<MedioUtilizaCAModel>.from(
        json.decode(str).map((x) => MedioUtilizaCAModel.fromJson(x)));

class MedioUtilizaCAModel extends MedioUtilizaCAEntity {
  MedioUtilizaCAModel({
    required int medioUtilizaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          medioUtilizaId: medioUtilizaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory MedioUtilizaCAModel.fromJson(Map<String, dynamic> json) =>
      MedioUtilizaCAModel(
        medioUtilizaId: json["MedioUtiliza_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
