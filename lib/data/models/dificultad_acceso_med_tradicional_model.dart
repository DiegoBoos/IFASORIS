import 'dart:convert';

import '../../domain/entities/dificultad_acceso_med_tradicional_entity.dart';

List<DificultadAccesoMedTradicionalModel>
    dificultadesAccesoMedTradicionalModelFromJson(String str) =>
        List<DificultadAccesoMedTradicionalModel>.from(json
            .decode(str)
            .map((x) => DificultadAccesoMedTradicionalModel.fromJson(x)));

class DificultadAccesoMedTradicionalModel
    extends DificultadAccesoMedTradicionalEntity {
  DificultadAccesoMedTradicionalModel({
    required int dificultaAccesoMedTradId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          dificultaAccesoMedTradId: dificultaAccesoMedTradId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory DificultadAccesoMedTradicionalModel.fromJson(
          Map<String, dynamic> json) =>
      DificultadAccesoMedTradicionalModel(
        dificultaAccesoMedTradId: json["dificultaAccesoMedTrad_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "dificultaAccesoMedTrad_id": dificultaAccesoMedTradId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
