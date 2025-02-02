import 'dart:convert';

import '../../domain/entities/dificultad_acceso_med_tradicional.dart';

List<DificultadAccesoMedTradicionalModel>
    dificultadesAccesoMedTradicionalFromJson(String str) =>
        List<DificultadAccesoMedTradicionalModel>.from(json
            .decode(str)
            .map((x) => DificultadAccesoMedTradicionalModel.fromJson(x)));

class DificultadAccesoMedTradicionalModel
    extends DificultadAccesoMedTradicionalEntity {
  const DificultadAccesoMedTradicionalModel({
    super.dificultadAccesoMedTradId,
    super.descripcion,
    super.departamentoIde,
  });

  factory DificultadAccesoMedTradicionalModel.fromEntity(
      DificultadAccesoMedTradicionalEntity entity) {
    return DificultadAccesoMedTradicionalModel(
      dificultadAccesoMedTradId: entity.dificultadAccesoMedTradId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory DificultadAccesoMedTradicionalModel.fromJson(
          Map<String, dynamic> json) =>
      DificultadAccesoMedTradicionalModel(
        dificultadAccesoMedTradId: json["DificultadAccesoMedTrad_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "DificultadAccesoMedTrad_id": dificultadAccesoMedTradId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstDificultadAccesoMedTradicional {
  int? ubicacionId;
  int? dificultadAccesoMedTradId;

  LstDificultadAccesoMedTradicional({
    this.ubicacionId,
    this.dificultadAccesoMedTradId,
  });

  factory LstDificultadAccesoMedTradicional.fromJson(
          Map<String, dynamic> json) =>
      LstDificultadAccesoMedTradicional(
        dificultadAccesoMedTradId: json["DificultadAccesoMedTrad_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "DificultadAccesoMedTrad_id": dificultadAccesoMedTradId,
      };
}

List<UbicacionDificultadAccesoMedTradicional>
    ubicacionDificultadAccesoMedTradicionalFromJson(String str) =>
        List<UbicacionDificultadAccesoMedTradicional>.from(json
            .decode(str)
            .map((x) => UbicacionDificultadAccesoMedTradicional.fromJson(x)));

class UbicacionDificultadAccesoMedTradicional {
  int? ubicacionDificultadAccesoMedTradId;
  int? ubicacionId;
  int? dificultadAccesoMedTradId;

  UbicacionDificultadAccesoMedTradicional({
    this.ubicacionDificultadAccesoMedTradId,
    this.ubicacionId,
    this.dificultadAccesoMedTradId,
  });

  factory UbicacionDificultadAccesoMedTradicional.fromJson(
          Map<String, dynamic> json) =>
      UbicacionDificultadAccesoMedTradicional(
        ubicacionDificultadAccesoMedTradId:
            json["UbicacionAccesoMedTradicional_id"],
        ubicacionId: json["Ubicacion_id"],
        dificultadAccesoMedTradId: json["DificultadAccesoMedTrad_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "DificultadAccesoMedTrad_id": dificultadAccesoMedTradId,
      };
}
