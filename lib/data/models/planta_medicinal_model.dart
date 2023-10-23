import 'dart:convert';

import 'package:ifasoris/domain/entities/planta_medicinal_entity.dart';

List<PlantaMedicinalModel> plantasMedicinalesFromJson(String str) =>
    List<PlantaMedicinalModel>.from(
        json.decode(str).map((x) => PlantaMedicinalModel.fromJson(x)));

class PlantaMedicinalModel extends PlantaMedicinalEntity {
  PlantaMedicinalModel({
    required int plantaMedicinalId,
    required String descripcion,
  }) : super(plantaMedicinalId: plantaMedicinalId, descripcion: descripcion);

  factory PlantaMedicinalModel.fromJson(Map<String, dynamic> json) =>
      PlantaMedicinalModel(
        plantaMedicinalId: json["PlantaMedicinal_id"],
        descripcion: json["Descripcion"],
      );
}

class LstPlantaMedicinal {
  int? atencionSaludId;
  int? plantaMedicinalId;

  LstPlantaMedicinal({
    this.atencionSaludId,
    this.plantaMedicinalId,
  });

  factory LstPlantaMedicinal.fromJson(Map<String, dynamic> json) =>
      LstPlantaMedicinal(
        plantaMedicinalId: json["PlantaMedicinal_id"],
      );

  Map<String, dynamic> toJson() => {
        "AtencionSalud_id": atencionSaludId,
        "PlantaMedicinal_id": plantaMedicinalId,
      };
}

List<LstPlantaMedicinal> listPlantaMedicinalFromJson(String str) =>
    List<LstPlantaMedicinal>.from(
        json.decode(str).map((x) => LstPlantaMedicinal.fromJson(x)));

List<PlantaMedicinalAtencionSalud> plantasMedicinalesAtencionSaludFromJson(
        String str) =>
    List<PlantaMedicinalAtencionSalud>.from(
        json.decode(str).map((x) => PlantaMedicinalAtencionSalud.fromJson(x)));

class PlantaMedicinalAtencionSalud {
  int? plantaMedicinalAtencionSaludId;
  int? atencionSaludId;
  int? plantaMedicinalId;

  PlantaMedicinalAtencionSalud({
    this.plantaMedicinalAtencionSaludId,
    this.atencionSaludId,
    this.plantaMedicinalId,
  });

  factory PlantaMedicinalAtencionSalud.fromJson(Map<String, dynamic> json) =>
      PlantaMedicinalAtencionSalud(
        plantaMedicinalAtencionSaludId:
            json["PlantasMedicinales_AtencionSalud_id"],
        atencionSaludId: json["AtencionSalud_id"],
        plantaMedicinalId: json["PlantaMedicinal_id"],
      );

  Map<String, dynamic> toJson() => {
        "AtencionSalud_id": atencionSaludId,
        "PlantaMedicinal_id": plantaMedicinalId,
      };
}
