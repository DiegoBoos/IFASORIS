import 'dart:convert';

import '../../domain/entities/medio_utiliza_med_tradicional_by_dpto_entity.dart';

List<MedioUtilizaMedTradicionalByDptoModel>
    mediosUtilizaMedTradicionalByDptoFromJson(String str) =>
        List<MedioUtilizaMedTradicionalByDptoModel>.from(json
            .decode(str)
            .map((x) => MedioUtilizaMedTradicionalByDptoModel.fromJson(x)));

class MedioUtilizaMedTradicionalByDptoModel
    extends MedioUtilizaMedTradicionalByDptoEntity {
  MedioUtilizaMedTradicionalByDptoModel({
    required int medioUtilizaMedTradId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          medioUtilizaMedTradId: medioUtilizaMedTradId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory MedioUtilizaMedTradicionalByDptoModel.fromJson(
          Map<String, dynamic> json) =>
      MedioUtilizaMedTradicionalByDptoModel(
        medioUtilizaMedTradId: json["medioUtilizaMedTrad_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "medioUtilizaMedTrad_id": medioUtilizaMedTradId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
