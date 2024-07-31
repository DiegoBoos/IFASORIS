import 'dart:convert';

import '../../domain/entities/medio_utiliza_med_tradicional.dart';

List<MedioUtilizaMedTradicionalModel> mediosUtilizaMedTradicionalFromJson(
        String str) =>
    List<MedioUtilizaMedTradicionalModel>.from(json
        .decode(str)
        .map((x) => MedioUtilizaMedTradicionalModel.fromJson(x)));

class MedioUtilizaMedTradicionalModel extends MedioUtilizaMedTradicionalEntity {
  const MedioUtilizaMedTradicionalModel({
    int? medioUtilizaMedTradId,
    String? descripcion,
    int? departamentoIde,
  });

  static MedioUtilizaMedTradicionalModel fromEntity(
      MedioUtilizaMedTradicionalEntity entity) {
    return MedioUtilizaMedTradicionalModel(
      medioUtilizaMedTradId: entity.medioUtilizaMedTradId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory MedioUtilizaMedTradicionalModel.fromJson(Map<String, dynamic> json) =>
      MedioUtilizaMedTradicionalModel(
        medioUtilizaMedTradId: json["MedioUtilizaMedTrad_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "MedioUtilizaMedTrad_id": medioUtilizaMedTradId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstMediosMedTradicional {
  int? ubicacionId;
  int? medioUtilizaMedTradId;

  LstMediosMedTradicional({
    this.ubicacionId,
    this.medioUtilizaMedTradId,
  });

  factory LstMediosMedTradicional.fromJson(Map<String, dynamic> json) =>
      LstMediosMedTradicional(
        medioUtilizaMedTradId: json["MedioUtilizaMedTrad_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "MedioUtilizaMedTrad_id": medioUtilizaMedTradId,
      };
}

List<UbicacionMediosMedTradicional> ubicacionMediosMedTradicionalFromJson(
        String str) =>
    List<UbicacionMediosMedTradicional>.from(
        json.decode(str).map((x) => UbicacionMediosMedTradicional.fromJson(x)));

class UbicacionMediosMedTradicional {
  int? ubicacionMediosMedTradicionalId;
  int? ubicacionId;
  int? medioUtilizaMedTradicionalId;

  UbicacionMediosMedTradicional({
    this.ubicacionMediosMedTradicionalId,
    this.ubicacionId,
    this.medioUtilizaMedTradicionalId,
  });

  factory UbicacionMediosMedTradicional.fromJson(Map<String, dynamic> json) =>
      UbicacionMediosMedTradicional(
        ubicacionMediosMedTradicionalId:
            json["UbicacionMediosMedTradicional_id"],
        ubicacionId: json["Ubicacion_id"],
        medioUtilizaMedTradicionalId: json["MedioUtilizaMedTrad_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "MedioUtilizaMedTrad_id": medioUtilizaMedTradicionalId,
      };
}
