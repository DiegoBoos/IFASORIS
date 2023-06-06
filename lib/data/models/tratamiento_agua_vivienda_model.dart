import 'dart:convert';

import '../../domain/entities/tratamiento_agua_vivienda_entity.dart';

List<TratamientoAguaViviendaModel> tratamientosAguaViviendaFromJson(
        String str) =>
    List<TratamientoAguaViviendaModel>.from(
        json.decode(str).map((x) => TratamientoAguaViviendaModel.fromJson(x)));

class TratamientoAguaViviendaModel extends TratamientoAguaViviendaEntity {
  TratamientoAguaViviendaModel({
    required int tratamientoAguaViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          tratamientoAguaViviendaId: tratamientoAguaViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TratamientoAguaViviendaModel.fromJson(Map<String, dynamic> json) =>
      TratamientoAguaViviendaModel(
        tratamientoAguaViviendaId: json["TratamientoAguaVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstTmtoAgua {
  int? tratamientoAguaViviendaId;

  LstTmtoAgua({
    this.tratamientoAguaViviendaId,
  });

  factory LstTmtoAgua.fromJson(Map<String, dynamic> json) => LstTmtoAgua(
        tratamientoAguaViviendaId: json["TratamientoAguaVivienda_id"],
      );

  Map<String, dynamic> toJson() => {
        "TratamientoAguaVivienda_id": tratamientoAguaViviendaId,
      };
}

List<ViviendaTratamientosAgua> viviendaTratamientosAguaFromJson(String str) =>
    List<ViviendaTratamientosAgua>.from(
        json.decode(str).map((x) => ViviendaTratamientosAgua.fromJson(x)));

class ViviendaTratamientosAgua {
  int? viviendaTmtoAguaId;
  int? datoViviendaId;
  int? tratamientoAguaViviendaId;

  ViviendaTratamientosAgua({
    this.viviendaTmtoAguaId,
    this.datoViviendaId,
    this.tratamientoAguaViviendaId,
  });

  factory ViviendaTratamientosAgua.fromJson(Map<String, dynamic> json) =>
      ViviendaTratamientosAgua(
        viviendaTmtoAguaId: json["ViviendaTmtoAgua_id"],
        datoViviendaId: json["DatoVivienda_id"],
        tratamientoAguaViviendaId: json["TratamientoAguaVivienda_id"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "TratamientoAguaVivienda_id": tratamientoAguaViviendaId,
      };
}
