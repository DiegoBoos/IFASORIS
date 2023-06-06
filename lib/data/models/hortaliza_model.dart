import 'dart:convert';

import 'package:ifasoris/domain/entities/hortaliza_entity.dart';

List<HortalizaModel> hortalizasFromJson(String str) =>
    List<HortalizaModel>.from(
        json.decode(str).map((x) => HortalizaModel.fromJson(x)));

class HortalizaModel extends HortalizaEntity {
  HortalizaModel({
    required int hortalizaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          hortalizaId: hortalizaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory HortalizaModel.fromJson(Map<String, dynamic> json) => HortalizaModel(
        hortalizaId: json["Hortaliza_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstHortaliza {
  int? hortalizaId;

  LstHortaliza({
    this.hortalizaId,
  });

  factory LstHortaliza.fromJson(Map<String, dynamic> json) => LstHortaliza(
        hortalizaId: json["Hortaliza_id"],
      );

  Map<String, dynamic> toJson() => {
        "Hortaliza_id": hortalizaId,
      };
}

List<UbicacionHortalizas> ubicacionHortalizasFromJson(String str) =>
    List<UbicacionHortalizas>.from(
        json.decode(str).map((x) => UbicacionHortalizas.fromJson(x)));

class UbicacionHortalizas {
  int? ubicacionHortalizaId;
  int? ubicacionId;
  int? hortalizaId;

  UbicacionHortalizas({
    this.ubicacionHortalizaId,
    this.ubicacionId,
    this.hortalizaId,
  });

  factory UbicacionHortalizas.fromJson(Map<String, dynamic> json) =>
      UbicacionHortalizas(
        ubicacionHortalizaId: json["UbicacionHortaliza_id"],
        ubicacionId: json["Ubicacion_id"],
        hortalizaId: json["Hortaliza_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Hortaliza_id": hortalizaId,
      };
}
