import 'dart:convert';

import '../../domain/entities/tipo_sanitario_vivienda_entity.dart';

List<TipoSanitarioViviendaModel> tiposSanitarioViviendaFromJson(String str) =>
    List<TipoSanitarioViviendaModel>.from(
        json.decode(str).map((x) => TipoSanitarioViviendaModel.fromJson(x)));

class TipoSanitarioViviendaModel extends TipoSanitarioViviendaEntity {
  TipoSanitarioViviendaModel({
    required int tipoSanitarioViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          tipoSanitarioViviendaId: tipoSanitarioViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TipoSanitarioViviendaModel.fromJson(Map<String, dynamic> json) =>
      TipoSanitarioViviendaModel(
        tipoSanitarioViviendaId: json["TipoSanitarioVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstTipoSanitario {
  int? viviendaId;
  int? tipoSanitarioViviendaId;
  String? otroTipoSanitario;

  LstTipoSanitario({
    this.viviendaId,
    this.tipoSanitarioViviendaId,
    this.otroTipoSanitario,
  });

  factory LstTipoSanitario.fromJson(Map<String, dynamic> json) =>
      LstTipoSanitario(
        tipoSanitarioViviendaId: json["TipoSanitarioVivienda_id"],
        otroTipoSanitario: json["OtroTipoSanitario"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": viviendaId,
        "TipoSanitarioVivienda_id": tipoSanitarioViviendaId,
        "OtroTipoSanitario": otroTipoSanitario,
      };
}

List<ViviendaTiposSanitario> viviendaTiposSanitarioFromJson(String str) =>
    List<ViviendaTiposSanitario>.from(
        json.decode(str).map((x) => ViviendaTiposSanitario.fromJson(x)));

class ViviendaTiposSanitario {
  int? viviendaTipoSanitarioId;
  int? datoViviendaId;
  int? tipoSanitarioViviendaId;
  String? otroTipoSanitario;

  ViviendaTiposSanitario({
    this.viviendaTipoSanitarioId,
    this.datoViviendaId,
    this.tipoSanitarioViviendaId,
    this.otroTipoSanitario,
  });

  factory ViviendaTiposSanitario.fromJson(Map<String, dynamic> json) =>
      ViviendaTiposSanitario(
        viviendaTipoSanitarioId: json["ViviendaTipoSanitario_id"],
        datoViviendaId: json["DatoVivienda_id"],
        tipoSanitarioViviendaId: json["TipoSanitarioVivienda_id"],
        otroTipoSanitario: json["OtroTipoSanitario"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "TipoSanitarioVivienda_id": tipoSanitarioViviendaId,
        "OtroTipoSanitario": otroTipoSanitario,
      };
}
