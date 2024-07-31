import 'dart:convert';

import 'package:ifasoris/domain/entities/servicio_solicitado.dart';

List<ServicioSolicitadoModel> serviciosSolicitadosFromJson(String str) =>
    List<ServicioSolicitadoModel>.from(
        json.decode(str).map((x) => ServicioSolicitadoModel.fromJson(x)));

class ServicioSolicitadoModel extends ServicioSolicitadoEntity {
  const ServicioSolicitadoModel({
    int? servicioSolicitadoId,
    String? descripcion,
  });

  static ServicioSolicitadoModel fromEntity(ServicioSolicitadoEntity entity) {
    return ServicioSolicitadoModel(
      servicioSolicitadoId: entity.servicioSolicitadoId,
      descripcion: entity.descripcion,
    );
  }

  factory ServicioSolicitadoModel.fromJson(Map<String, dynamic> json) =>
      ServicioSolicitadoModel(
        servicioSolicitadoId: json["ServicioSolicitado_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "ServicioSolicitado_id": servicioSolicitadoId,
        "Descripcion": descripcion,
      };
}

class LstServicioSolicitado {
  int? cuidadoSaludCondRiesgoId;
  int? servicioSolicitadoId;

  LstServicioSolicitado({
    this.cuidadoSaludCondRiesgoId,
    this.servicioSolicitadoId,
  });

  factory LstServicioSolicitado.fromJson(Map<String, dynamic> json) =>
      LstServicioSolicitado(
        servicioSolicitadoId: json["ServicioSolicitado_id"],
      );

  Map<String, dynamic> toJson() => {
        "CuidadoSaludCondRiesgo_id": cuidadoSaludCondRiesgoId,
        "ServicioSolicitado_id": servicioSolicitadoId,
      };
}

List<LstServicioSolicitado> listServiciosSolicitadosFromJson(String str) =>
    List<LstServicioSolicitado>.from(
        json.decode(str).map((x) => LstServicioSolicitado.fromJson(x)));

List<CuidadoSaludCondRiesgoServiciosSolicitados>
    cuidadoSaludCondRiesgoServiciosSolicitadosFromJson(String str) =>
        List<CuidadoSaludCondRiesgoServiciosSolicitados>.from(json
            .decode(str)
            .map(
                (x) => CuidadoSaludCondRiesgoServiciosSolicitados.fromJson(x)));

class CuidadoSaludCondRiesgoServiciosSolicitados {
  int? cuidadoSaludCondRiesgoServicioSolicitadoId;
  int? cuidadoSaludCondRiesgoId;
  int? servicioSolicitadoId;

  CuidadoSaludCondRiesgoServiciosSolicitados({
    this.cuidadoSaludCondRiesgoServicioSolicitadoId,
    this.cuidadoSaludCondRiesgoId,
    this.servicioSolicitadoId,
  });

  factory CuidadoSaludCondRiesgoServiciosSolicitados.fromJson(
          Map<String, dynamic> json) =>
      CuidadoSaludCondRiesgoServiciosSolicitados(
        cuidadoSaludCondRiesgoServicioSolicitadoId:
            json["CuidadoSaludCondRiesgoServiciosSolicita_id"],
        cuidadoSaludCondRiesgoId: json["CuidadoSaludCondRiesgo_id"],
        servicioSolicitadoId: json["ServicioSolicitado_id"],
      );

  Map<String, dynamic> toJson() => {
        "CuidadoSaludCondRiesgo_id": cuidadoSaludCondRiesgoId,
        "ServicioSolicitado_id": servicioSolicitadoId,
      };
}
