import 'dart:convert';

import 'package:ifasoris/domain/entities/nombre_enfermedad.dart';

List<NombreEnfermedadModel> nombresEnfermedadesFromJson(String str) =>
    List<NombreEnfermedadModel>.from(
        json.decode(str).map((x) => NombreEnfermedadModel.fromJson(x)));

class NombreEnfermedadModel extends NombreEnfermedadEntity {
  const NombreEnfermedadModel({
    int? nombreEnfermedadId,
    String? descripcion,
  });

  static NombreEnfermedadModel fromEntity(NombreEnfermedadEntity entity) {
    return NombreEnfermedadModel(
      nombreEnfermedadId: entity.nombreEnfermedadId,
      descripcion: entity.descripcion,
    );
  }

  factory NombreEnfermedadModel.fromJson(Map<String, dynamic> json) =>
      NombreEnfermedadModel(
        nombreEnfermedadId: json["NombreEnfermedad_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "NombreEnfermedad_id": nombreEnfermedadId,
        "Descripcion": descripcion,
      };
}

class LstNombreEnfermedad {
  int? cuidadoSaludCondRiesgoId;
  int? nombreEnfermedadId;

  LstNombreEnfermedad({
    this.cuidadoSaludCondRiesgoId,
    this.nombreEnfermedadId,
  });

  factory LstNombreEnfermedad.fromJson(Map<String, dynamic> json) =>
      LstNombreEnfermedad(
        nombreEnfermedadId: json["NombreEnfermedad_id"],
      );

  Map<String, dynamic> toJson() => {
        "CuidadoSaludCondRiesgo_id": cuidadoSaludCondRiesgoId,
        "NombreEnfermedad_id": nombreEnfermedadId,
      };
}

List<LstNombreEnfermedad> listNombreEnfermedadFromJson(String str) =>
    List<LstNombreEnfermedad>.from(
        json.decode(str).map((x) => LstNombreEnfermedad.fromJson(x)));

List<CuidadoSaludCondRiesgoNombreEnfermedad>
    cuidadoSaludCondRiesgoNombresEnfermedadesFromJson(String str) =>
        List<CuidadoSaludCondRiesgoNombreEnfermedad>.from(json
            .decode(str)
            .map((x) => CuidadoSaludCondRiesgoNombreEnfermedad.fromJson(x)));

class CuidadoSaludCondRiesgoNombreEnfermedad {
  int? cuidadoSaludCondRiesgoNombreEnfermedadId;
  int? cuidadoSaludCondRiesgoId;
  int? nombreEnfermedadId;

  CuidadoSaludCondRiesgoNombreEnfermedad({
    this.cuidadoSaludCondRiesgoNombreEnfermedadId,
    this.cuidadoSaludCondRiesgoId,
    this.nombreEnfermedadId,
  });

  factory CuidadoSaludCondRiesgoNombreEnfermedad.fromJson(
          Map<String, dynamic> json) =>
      CuidadoSaludCondRiesgoNombreEnfermedad(
        cuidadoSaludCondRiesgoNombreEnfermedadId:
            json["CuidadoSaludCondRiesgoNombresEnfermedad_id"],
        cuidadoSaludCondRiesgoId: json["CuidadoSaludCondRiesgo_id"],
        nombreEnfermedadId: json["NombreEnfermedad_id"],
      );

  Map<String, dynamic> toJson() => {
        "CuidadoSaludCondRiesgo_id": cuidadoSaludCondRiesgoId,
        "NombreEnfermedad_id": nombreEnfermedadId,
      };
}
