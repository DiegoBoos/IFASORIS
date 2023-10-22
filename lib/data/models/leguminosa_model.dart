import 'dart:convert';

import '../../domain/entities/leguminosa_entity.dart';

List<LeguminosaModel> leguminosasFromJson(String str) =>
    List<LeguminosaModel>.from(
        json.decode(str).map((x) => LeguminosaModel.fromJson(x)));

class LeguminosaModel extends LeguminosaEntity {
  LeguminosaModel({
    required int leguminosaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          leguminosaId: leguminosaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory LeguminosaModel.fromJson(Map<String, dynamic> json) =>
      LeguminosaModel(
        leguminosaId: json["Leguminosa_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
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
