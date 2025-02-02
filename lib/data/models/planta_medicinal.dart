import 'dart:convert';

import 'package:ifasoris/domain/entities/planta_medicinal.dart';

List<PlantaMedicinalModel> plantasMedicinalesFromJson(String str) =>
    List<PlantaMedicinalModel>.from(
        json.decode(str).map((x) => PlantaMedicinalModel.fromJson(x)));

class PlantaMedicinalModel extends PlantaMedicinalEntity {
  const PlantaMedicinalModel({
    super.plantaMedicinalId,
    super.descripcion,
  });

  factory PlantaMedicinalModel.fromEntity(PlantaMedicinalEntity entity) {
    return PlantaMedicinalModel(
      plantaMedicinalId: entity.plantaMedicinalId,
      descripcion: entity.descripcion,
    );
  }

  factory PlantaMedicinalModel.fromJson(Map<String, dynamic> json) =>
      PlantaMedicinalModel(
        plantaMedicinalId: json["PlantaMedicinal_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "PlantaMedicinal_id": plantaMedicinalId,
        "Descripcion": descripcion,
      };
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
