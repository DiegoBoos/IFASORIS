import 'dart:convert';

import '../../domain/entities/medio_utiliza_med_tradicional_entity.dart';

List<MedioUtilizaMedTradicionalModel> mediosUtilizaMedTradicionalFromJson(
        String str) =>
    List<MedioUtilizaMedTradicionalModel>.from(json
        .decode(str)
        .map((x) => MedioUtilizaMedTradicionalModel.fromJson(x)));

class MedioUtilizaMedTradicionalModel extends MedioUtilizaMedTradicionalEntity {
  MedioUtilizaMedTradicionalModel({
    required int medioUtilizaMedTradId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          medioUtilizaMedTradId: medioUtilizaMedTradId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory MedioUtilizaMedTradicionalModel.fromJson(Map<String, dynamic> json) =>
      MedioUtilizaMedTradicionalModel(
        medioUtilizaMedTradId: json["MedioUtilizaMedTrad_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
