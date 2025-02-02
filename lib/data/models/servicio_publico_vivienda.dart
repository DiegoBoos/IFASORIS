import 'dart:convert';

import '../../domain/entities/servicio_publico_vivienda.dart';

List<ServicioPublicoViviendaModel> serviciosPublicosViviendaFromJson(
        String str) =>
    List<ServicioPublicoViviendaModel>.from(
        json.decode(str).map((x) => ServicioPublicoViviendaModel.fromJson(x)));

class ServicioPublicoViviendaModel extends ServicioPublicoViviendaEntity {
  const ServicioPublicoViviendaModel({
    super.servicioPublicoViviendaId,
    super.descripcion,
    super.departamentoIde,
  });

  factory ServicioPublicoViviendaModel.fromEntity(
      ServicioPublicoViviendaEntity entity) {
    return ServicioPublicoViviendaModel(
      servicioPublicoViviendaId: entity.servicioPublicoViviendaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory ServicioPublicoViviendaModel.fromJson(Map<String, dynamic> json) =>
      ServicioPublicoViviendaModel(
        servicioPublicoViviendaId: json["ServicioPublicoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "ServicioPublicoVivienda_id": servicioPublicoViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstServPublico {
  int? viviendaId;
  int? servicioPublicoViviendaId;

  LstServPublico({
    this.viviendaId,
    this.servicioPublicoViviendaId,
  });

  factory LstServPublico.fromJson(Map<String, dynamic> json) => LstServPublico(
        servicioPublicoViviendaId: json["ServicioPublicoVivienda_id"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": viviendaId,
        "ServicioPublicoVivienda_id": servicioPublicoViviendaId,
      };
}

List<ViviendaServiciosPublicos> viviendaServiciosPublicosFromJson(String str) =>
    List<ViviendaServiciosPublicos>.from(
        json.decode(str).map((x) => ViviendaServiciosPublicos.fromJson(x)));

class ViviendaServiciosPublicos {
  int? viviendaServicioPublicoId;
  int? datoViviendaId;
  int? servicioPublicoViviendaId;

  ViviendaServiciosPublicos({
    this.viviendaServicioPublicoId,
    this.datoViviendaId,
    this.servicioPublicoViviendaId,
  });

  factory ViviendaServiciosPublicos.fromJson(Map<String, dynamic> json) =>
      ViviendaServiciosPublicos(
        viviendaServicioPublicoId: json["ViviendaServicioPublico_id"],
        datoViviendaId: json["DatoVivienda_id"],
        servicioPublicoViviendaId: json["ServicioPublicoVivienda_id"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "ServicioPublicoVivienda_id": servicioPublicoViviendaId,
      };
}
