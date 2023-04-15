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
    required int dificultadAccesoMedTradId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          dificultadAccesoMedTradId: dificultadAccesoMedTradId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory DificultadAccesoMedTradicionalModel.fromJson(
          Map<String, dynamic> json) =>
      DificultadAccesoMedTradicionalModel(
        dificultadAccesoMedTradId: json["DificultadAccesoMedTrad_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
