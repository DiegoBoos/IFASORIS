import 'dart:convert';

import '../../domain/entities/cereal.dart';

List<CerealModel> cerealesFromJson(String str) => List<CerealModel>.from(
    json.decode(str).map((x) => CerealModel.fromJson(x)));

class CerealModel extends CerealEntity {
  const CerealModel({
    int? cerealId,
    String? descripcion,
    int? departamentoIde,
  });

  static CerealModel fromEntity(CerealEntity entity) {
    return CerealModel(
      cerealId: entity.cerealId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory CerealModel.fromJson(Map<String, dynamic> json) => CerealModel(
        cerealId: json["Cereal_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "Cereal_id": cerealId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstCereal {
  int? cerealId;
  String? otroCereal;

  LstCereal({
    this.cerealId,
    this.otroCereal,
  });

  factory LstCereal.fromJson(Map<String, dynamic> json) => LstCereal(
        cerealId: json["Cereal_id"],
        otroCereal: json["OtroCereal"],
      );

  Map<String, dynamic> toJson() => {
        "Cereal_id": cerealId,
        "OtroCereal": otroCereal,
      };
}

List<UbicacionCereales> ubicacionCerealesFromJson(String str) =>
    List<UbicacionCereales>.from(
        json.decode(str).map((x) => UbicacionCereales.fromJson(x)));

class UbicacionCereales {
  int? ubicacionCerealId;
  int? ubicacionId;
  int? cerealId;
  String? otroCereal;

  UbicacionCereales({
    this.ubicacionCerealId,
    this.ubicacionId,
    this.cerealId,
    this.otroCereal,
  });

  factory UbicacionCereales.fromJson(Map<String, dynamic> json) =>
      UbicacionCereales(
        ubicacionCerealId: json["UbicacionCereal_id"],
        ubicacionId: json["Ubicacion_id"],
        cerealId: json["Cereal_id"],
        otroCereal: json["OtroCereal"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Cereal_id": cerealId,
        "OtroCereal": otroCereal,
      };
}
