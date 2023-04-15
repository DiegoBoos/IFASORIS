import 'dart:convert';

import 'package:ifasoris/domain/entities/especialidad_med_tradicional_entity.dart';

List<EspecialidadMedTradicionalModel> especialidadesMedTradicionalFromJson(
        String str) =>
    List<EspecialidadMedTradicionalModel>.from(json
        .decode(str)
        .map((x) => EspecialidadMedTradicionalModel.fromJson(x)));

class EspecialidadMedTradicionalModel extends EspecialidadMedTradicionalEntity {
  EspecialidadMedTradicionalModel({
    required int especialidadMedTradId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          especialidadMedTradId: especialidadMedTradId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory EspecialidadMedTradicionalModel.fromJson(Map<String, dynamic> json) =>
      EspecialidadMedTradicionalModel(
        especialidadMedTradId: json["EspecialidadMedTrad_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
