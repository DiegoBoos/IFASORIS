import 'dart:convert';

import '../../domain/entities/leguminosa.dart';

List<LeguminosaModel> leguminosasFromJson(String str) =>
    List<LeguminosaModel>.from(
        json.decode(str).map((x) => LeguminosaModel.fromJson(x)));

class LeguminosaModel extends LeguminosaEntity {
  const LeguminosaModel({
    super.leguminosaId,
    super.descripcion,
    super.departamentoIde,
  });

  factory LeguminosaModel.fromEntity(LeguminosaEntity entity) {
    return LeguminosaModel(
      leguminosaId: entity.leguminosaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory LeguminosaModel.fromJson(Map<String, dynamic> json) =>
      LeguminosaModel(
        leguminosaId: json["Leguminosa_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "Leguminosa_id": leguminosaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstLeguminosa {
  int? ubicacionId;
  int? leguminosaId;

  LstLeguminosa({
    this.ubicacionId,
    this.leguminosaId,
  });

  factory LstLeguminosa.fromJson(Map<String, dynamic> json) => LstLeguminosa(
        leguminosaId: json["Leguminosa_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Leguminosa_id": leguminosaId,
      };
}

List<UbicacionLeguminosas> ubicacionLeguminosasFromJson(String str) =>
    List<UbicacionLeguminosas>.from(
        json.decode(str).map((x) => UbicacionLeguminosas.fromJson(x)));

class UbicacionLeguminosas {
  int? ubicacionLeguminosaId;
  int? ubicacionId;
  int? leguminosaId;

  UbicacionLeguminosas({
    this.ubicacionLeguminosaId,
    this.ubicacionId,
    this.leguminosaId,
  });

  factory UbicacionLeguminosas.fromJson(Map<String, dynamic> json) =>
      UbicacionLeguminosas(
        ubicacionLeguminosaId: json["UbicacionLeguminosa_id"],
        ubicacionId: json["Ubicacion_id"],
        leguminosaId: json["Leguminosa_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Leguminosa_id": leguminosaId,
      };
}
