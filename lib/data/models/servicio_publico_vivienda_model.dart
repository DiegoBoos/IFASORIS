import 'dart:convert';

import '../../domain/entities/servicio_publico_vivienda_entity.dart';

List<ServicioPublicoViviendaModel> serviciosPublicosViviendaFromJson(
        String str) =>
    List<ServicioPublicoViviendaModel>.from(
        json.decode(str).map((x) => ServicioPublicoViviendaModel.fromJson(x)));

class ServicioPublicoViviendaModel extends ServicioPublicoViviendaEntity {
  ServicioPublicoViviendaModel({
    required int servicioPublicoViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          servicioPublicoViviendaId: servicioPublicoViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory ServicioPublicoViviendaModel.fromJson(Map<String, dynamic> json) =>
      ServicioPublicoViviendaModel(
        servicioPublicoViviendaId: json["ServicioPublicoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
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
