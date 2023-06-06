import 'dart:convert';

import '../../domain/entities/cereal_entity.dart';

List<CerealModel> cerealesFromJson(String str) => List<CerealModel>.from(
    json.decode(str).map((x) => CerealModel.fromJson(x)));

class CerealModel extends CerealEntity {
  CerealModel({
    required int cerealId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          cerealId: cerealId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory CerealModel.fromJson(Map<String, dynamic> json) => CerealModel(
        cerealId: json["Cereal_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstCereal {
  int? cerealId;

  LstCereal({
    this.cerealId,
  });

  factory LstCereal.fromJson(Map<String, dynamic> json) => LstCereal(
        cerealId: json["Cereal_id"],
      );

  Map<String, dynamic> toJson() => {
        "Cereal_id": cerealId,
      };
}

List<UbicacionCereales> ubicacionCerealesFromJson(String str) =>
    List<UbicacionCereales>.from(
        json.decode(str).map((x) => UbicacionCereales.fromJson(x)));

class UbicacionCereales {
  int? ubicacionCerealId;
  int? ubicacionId;
  int? cerealId;

  UbicacionCereales({
    this.ubicacionCerealId,
    this.ubicacionId,
    this.cerealId,
  });

  factory UbicacionCereales.fromJson(Map<String, dynamic> json) =>
      UbicacionCereales(
        ubicacionCerealId: json["UbicacionCereal_id"],
        ubicacionId: json["Ubicacion_id"],
        cerealId: json["Cereal_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Cereal_id": cerealId,
      };
}
