import 'dart:convert';

import 'package:ifasoris/domain/entities/dificultad_acceso_ca_entity.dart';

List<DificultadAccesoCAModel> dificultadesAccesoCAFromJson(String str) =>
    List<DificultadAccesoCAModel>.from(
        json.decode(str).map((x) => DificultadAccesoCAModel.fromJson(x)));

class DificultadAccesoCAModel extends DificultadAccesoCAEntity {
  DificultadAccesoCAModel({
    required int dificultaAccesoId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          dificultaAccesoId: dificultaAccesoId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory DificultadAccesoCAModel.fromJson(Map<String, dynamic> json) =>
      DificultadAccesoCAModel(
        dificultaAccesoId: json["DificultaAcceso_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstDificultadAccesoAtencion {
  int? dificultaAccesoId;

  LstDificultadAccesoAtencion({
    this.dificultaAccesoId,
  });

  factory LstDificultadAccesoAtencion.fromJson(Map<String, dynamic> json) =>
      LstDificultadAccesoAtencion(
        dificultaAccesoId: json["DificultaAcceso_id"],
      );

  Map<String, dynamic> toJson() => {
        "DificultaAcceso_id": dificultaAccesoId,
      };
}

List<UbicacionDificultadAcceso> ubicacionesDificultadAccesoFromJson(
        String str) =>
    List<UbicacionDificultadAcceso>.from(
        json.decode(str).map((x) => UbicacionDificultadAcceso.fromJson(x)));

class UbicacionDificultadAcceso {
  int? ubicacionDificultadAccesoId;
  int? ubicacionId;
  int? dificultadAccesoId;

  UbicacionDificultadAcceso({
    this.ubicacionDificultadAccesoId,
    this.ubicacionId,
    this.dificultadAccesoId,
  });

  factory UbicacionDificultadAcceso.fromJson(Map<String, dynamic> json) =>
      UbicacionDificultadAcceso(
        ubicacionDificultadAccesoId: json["UbicacionDificultadAcceso_id"],
        ubicacionId: json["Ubicacion_id"],
        dificultadAccesoId: json["DificultaAcceso_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "DificultaAcceso_id": dificultadAccesoId,
      };
}
