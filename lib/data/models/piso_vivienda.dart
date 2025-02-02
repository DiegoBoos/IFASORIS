import 'dart:convert';

import '../../domain/entities/piso_vivienda.dart';

List<PisoViviendaModel> pisosViviendaFromJson(String str) =>
    List<PisoViviendaModel>.from(
        json.decode(str).map((x) => PisoViviendaModel.fromJson(x)));

class PisoViviendaModel extends PisoViviendaEntity {
  const PisoViviendaModel({
    super.pisoViviendaId,
    super.descripcion,
    super.departamentoIde,
  });

  factory PisoViviendaModel.fromEntity(PisoViviendaEntity entity) {
    return PisoViviendaModel(
      pisoViviendaId: entity.pisoViviendaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory PisoViviendaModel.fromJson(Map<String, dynamic> json) =>
      PisoViviendaModel(
        pisoViviendaId: json["PisoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "PisoVivienda_id": pisoViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstPiso {
  int? viviendaId;
  int? pisoViviendaId;
  String? otroTipoPiso;

  LstPiso({
    this.viviendaId,
    this.pisoViviendaId,
    this.otroTipoPiso,
  });

  factory LstPiso.fromJson(Map<String, dynamic> json) => LstPiso(
        pisoViviendaId: json["PisoVivienda_id"],
        otroTipoPiso: json["OtroTipoPiso"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": viviendaId,
        "PisoVivienda_id": pisoViviendaId,
        "OtroTipoPiso": otroTipoPiso,
      };
}

List<ViviendaPisos> viviendaPisosFromJson(String str) =>
    List<ViviendaPisos>.from(
        json.decode(str).map((x) => ViviendaPisos.fromJson(x)));

class ViviendaPisos {
  int? viviendaPisoId;
  int? datoViviendaId;
  int? pisoViviendaId;
  String? otroTipoPiso;

  ViviendaPisos({
    this.viviendaPisoId,
    this.datoViviendaId,
    this.pisoViviendaId,
    this.otroTipoPiso,
  });

  factory ViviendaPisos.fromJson(Map<String, dynamic> json) => ViviendaPisos(
        viviendaPisoId: json["ViviendaPiso_id"],
        datoViviendaId: json["DatoVivienda_id"],
        pisoViviendaId: json["PisoVivienda_id"],
        otroTipoPiso: json["OtroTipoPiso"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "PisoVivienda_id": pisoViviendaId,
        "OtroTipoPiso": otroTipoPiso,
      };
}
