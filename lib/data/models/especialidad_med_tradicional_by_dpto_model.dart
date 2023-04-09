import 'dart:convert';

import 'package:ifasoris/domain/entities/especialidad_med_tradicional_by_dpto_entity.dart';

List<EspecialidadMedTradicionalByDptoModel>
    especialidadesMedTradicionalByDptoFromJson(String str) =>
        List<EspecialidadMedTradicionalByDptoModel>.from(json
            .decode(str)
            .map((x) => EspecialidadMedTradicionalByDptoModel.fromJson(x)));

class EspecialidadMedTradicionalByDptoModel
    extends EspecialidadMedTradicionalByDptoEntity {
  EspecialidadMedTradicionalByDptoModel({
    required int especialidadMedTradId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          especialidadMedTradId: especialidadMedTradId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory EspecialidadMedTradicionalByDptoModel.fromJson(
          Map<String, dynamic> json) =>
      EspecialidadMedTradicionalByDptoModel(
        especialidadMedTradId: json["especialidadMedTrad_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "especialidadMedTrad_id": especialidadMedTradId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
