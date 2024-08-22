import 'dart:convert';

import 'package:ifasoris/domain/entities/hortaliza.dart';

List<HortalizaModel> hortalizasFromJson(String str) =>
    List<HortalizaModel>.from(
        json.decode(str).map((x) => HortalizaModel.fromJson(x)));

class HortalizaModel extends HortalizaEntity {
  const HortalizaModel({
    int? hortalizaId,
    String? descripcion,
    int? departamentoIde,
  }) : super(
          hortalizaId: hortalizaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  static HortalizaModel fromEntity(HortalizaEntity entity) {
    return HortalizaModel(
      hortalizaId: entity.hortalizaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory HortalizaModel.fromJson(Map<String, dynamic> json) => HortalizaModel(
        hortalizaId: json["Hortaliza_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "Hortaliza_id": hortalizaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstHortaliza {
  int? ubicacionId;
  int? hortalizaId;
  String? otroHortaliza;

  LstHortaliza({
    this.ubicacionId,
    this.hortalizaId,
    this.otroHortaliza,
  });

  factory LstHortaliza.fromJson(Map<String, dynamic> json) => LstHortaliza(
        hortalizaId: json["Hortaliza_id"],
        otroHortaliza: json["OtroHortaliza"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Hortaliza_id": hortalizaId,
        "OtroHortaliza": otroHortaliza,
      };
}

List<UbicacionHortalizas> ubicacionHortalizasFromJson(String str) =>
    List<UbicacionHortalizas>.from(
        json.decode(str).map((x) => UbicacionHortalizas.fromJson(x)));

class UbicacionHortalizas {
  int? ubicacionHortalizaId;
  int? ubicacionId;
  int? hortalizaId;
  String? otroHortaliza;

  UbicacionHortalizas({
    this.ubicacionHortalizaId,
    this.ubicacionId,
    this.hortalizaId,
    this.otroHortaliza,
  });

  factory UbicacionHortalizas.fromJson(Map<String, dynamic> json) =>
      UbicacionHortalizas(
        ubicacionHortalizaId: json["UbicacionHortaliza_id"],
        ubicacionId: json["Ubicacion_id"],
        hortalizaId: json["Hortaliza_id"],
        otroHortaliza: json["OtroHortaliza"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Hortaliza_id": hortalizaId,
        "OtroHortaliza": otroHortaliza,
      };
}
