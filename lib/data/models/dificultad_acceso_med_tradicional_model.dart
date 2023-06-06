import 'dart:convert';

import '../../domain/entities/dificultad_acceso_med_tradicional_entity.dart';

List<DificultadAccesoMedTradicionalModel>
    dificultadesAccesoMedTradicionalFromJson(String str) =>
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

class LstDificultadAccesoMedTradicional {
  int? dificultadAccesoMedTradId;

  LstDificultadAccesoMedTradicional({
    this.dificultadAccesoMedTradId,
  });

  factory LstDificultadAccesoMedTradicional.fromJson(
          Map<String, dynamic> json) =>
      LstDificultadAccesoMedTradicional(
        dificultadAccesoMedTradId: json["DificultadAccesoMedTrad_id"],
      );

  Map<String, dynamic> toJson() => {
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
