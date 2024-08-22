import 'dart:convert';

import '../../domain/entities/tratamiento_agua_vivienda.dart';

List<TratamientoAguaViviendaModel> tratamientosAguaViviendaFromJson(
        String str) =>
    List<TratamientoAguaViviendaModel>.from(
        json.decode(str).map((x) => TratamientoAguaViviendaModel.fromJson(x)));

class TratamientoAguaViviendaModel extends TratamientoAguaViviendaEntity {
  const TratamientoAguaViviendaModel({
    int? tratamientoAguaViviendaId,
    String? descripcion,
    int? departamentoIde,
  }) : super(
          tratamientoAguaViviendaId: tratamientoAguaViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  static TratamientoAguaViviendaModel fromEntity(
      TratamientoAguaViviendaEntity entity) {
    return TratamientoAguaViviendaModel(
      tratamientoAguaViviendaId: entity.tratamientoAguaViviendaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory TratamientoAguaViviendaModel.fromJson(Map<String, dynamic> json) =>
      TratamientoAguaViviendaModel(
        tratamientoAguaViviendaId: json["TratamientoAguaVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "TratamientoAguaVivienda_id": tratamientoAguaViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstTmtoAgua {
  int? viviendaId;
  int? tratamientoAguaViviendaId;
  String? otroTratamientoAgua;

  LstTmtoAgua({
    this.viviendaId,
    this.tratamientoAguaViviendaId,
    this.otroTratamientoAgua,
  });

  factory LstTmtoAgua.fromJson(Map<String, dynamic> json) => LstTmtoAgua(
        tratamientoAguaViviendaId: json["TratamientoAguaVivienda_id"],
        otroTratamientoAgua: json["OtroTratamientoAgua"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": viviendaId,
        "TratamientoAguaVivienda_id": tratamientoAguaViviendaId,
        "OtroTratamientoAgua": otroTratamientoAgua,
      };
}

List<ViviendaTratamientosAgua> viviendaTratamientosAguaFromJson(String str) =>
    List<ViviendaTratamientosAgua>.from(
        json.decode(str).map((x) => ViviendaTratamientosAgua.fromJson(x)));

class ViviendaTratamientosAgua {
  int? viviendaTmtoAguaId;
  int? datoViviendaId;
  int? tratamientoAguaViviendaId;
  String? otroTratamientoAgua;

  ViviendaTratamientosAgua({
    this.viviendaTmtoAguaId,
    this.datoViviendaId,
    this.tratamientoAguaViviendaId,
    this.otroTratamientoAgua,
  });

  factory ViviendaTratamientosAgua.fromJson(Map<String, dynamic> json) =>
      ViviendaTratamientosAgua(
        viviendaTmtoAguaId: json["ViviendaTmtoAgua_id"],
        datoViviendaId: json["DatoVivienda_id"],
        tratamientoAguaViviendaId: json["TratamientoAguaVivienda_id"],
        otroTratamientoAgua: json["OtroTratamientoAgua"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "TratamientoAguaVivienda_id": tratamientoAguaViviendaId,
        "OtroTratamientoAgua": otroTratamientoAgua,
      };
}
