import 'dart:convert';

import 'package:ifasoris/domain/entities/dificultad_acceso_ca.dart';

List<DificultadAccesoCAModel> dificultadesAccesoCAFromJson(String str) =>
    List<DificultadAccesoCAModel>.from(
        json.decode(str).map((x) => DificultadAccesoCAModel.fromJson(x)));

class DificultadAccesoCAModel extends DificultadAccesoCAEntity {
  const DificultadAccesoCAModel({
    int? dificultaAccesoId,
    String? descripcion,
    int? departamentoIde,
  });

  static DificultadAccesoCAModel fromEntity(DificultadAccesoCAEntity entity) {
    return DificultadAccesoCAModel(
      dificultaAccesoId: entity.dificultaAccesoId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory DificultadAccesoCAModel.fromJson(Map<String, dynamic> json) =>
      DificultadAccesoCAModel(
        dificultaAccesoId: json["DificultaAcceso_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "DificultaAcceso_id": dificultaAccesoId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
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
