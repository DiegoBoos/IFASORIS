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

class LstEspMedTradicional {
  int? ubicacionId;
  int? especialidadMedTradId;

  LstEspMedTradicional({
    this.ubicacionId,
    this.especialidadMedTradId,
  });

  factory LstEspMedTradicional.fromJson(Map<String, dynamic> json) =>
      LstEspMedTradicional(
        especialidadMedTradId: json["EspecialidadMedTrad_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "EspecialidadMedTrad_id": especialidadMedTradId,
      };
}

List<UbicacionEspecialidadMedTradicional>
    ubicacionesEspecialidadMedTradicionalFromJson(String str) =>
        List<UbicacionEspecialidadMedTradicional>.from(json
            .decode(str)
            .map((x) => UbicacionEspecialidadMedTradicional.fromJson(x)));

class UbicacionEspecialidadMedTradicional {
  int? ubicacionEspecialidadMedTradicionalId;
  int? ubicacionId;
  int? especialidadMedTradicionalId;

  UbicacionEspecialidadMedTradicional({
    this.ubicacionEspecialidadMedTradicionalId,
    this.ubicacionId,
    this.especialidadMedTradicionalId,
  });

  factory UbicacionEspecialidadMedTradicional.fromJson(
          Map<String, dynamic> json) =>
      UbicacionEspecialidadMedTradicional(
        ubicacionEspecialidadMedTradicionalId:
            json["UbicacionEspMedTradicional_id"],
        ubicacionId: json["Ubicacion_id"],
        especialidadMedTradicionalId: json["EspecialidadMedTrad_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "EspecialidadMedTrad_id": especialidadMedTradicionalId,
      };
}

List<EspecialidadMedTradAtencionSalud>
    especialidadesMedTradAtencionSaludFromJson(String str) =>
        List<EspecialidadMedTradAtencionSalud>.from(json
            .decode(str)
            .map((x) => EspecialidadMedTradAtencionSalud.fromJson(x)));

class EspecialidadMedTradAtencionSalud {
  int? especialidadMedTradAtencionSaludId;
  int? atencionSaludId;
  int? especialidadMedTradId;

  EspecialidadMedTradAtencionSalud({
    this.especialidadMedTradAtencionSaludId,
    this.atencionSaludId,
    this.especialidadMedTradId,
  });

  factory EspecialidadMedTradAtencionSalud.fromJson(
          Map<String, dynamic> json) =>
      EspecialidadMedTradAtencionSalud(
        especialidadMedTradAtencionSaludId:
            json["EspecialidadesMedTradAtencionSalud_id"],
        atencionSaludId: json["AtencionSalud_id"],
        especialidadMedTradId: json["EspecialidadMedTrad_id"],
      );

  Map<String, dynamic> toJson() => {
        "AtencionSalud_id": atencionSaludId,
        "EspecialidadMedTrad_id": especialidadMedTradId,
      };
}
