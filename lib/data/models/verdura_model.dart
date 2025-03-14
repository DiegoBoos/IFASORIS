import 'dart:convert';

import 'package:ifasoris/domain/entities/verdura_entity.dart';

List<VerduraModel> verdurasFromJson(String str) => List<VerduraModel>.from(
    json.decode(str).map((x) => VerduraModel.fromJson(x)));

class VerduraModel extends VerduraEntity {
  VerduraModel({
    required int verduraId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          verduraId: verduraId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory VerduraModel.fromJson(Map<String, dynamic> json) => VerduraModel(
        verduraId: json["Verdura_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstVerdura {
  int? ubicacionId;
  int? verduraId;

  LstVerdura({
    this.ubicacionId,
    this.verduraId,
  });

  factory LstVerdura.fromJson(Map<String, dynamic> json) => LstVerdura(
        verduraId: json["Verdura_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Verdura_id": verduraId,
      };
}

List<UbicacionVerduras> ubicacionVerdurasFromJson(String str) =>
    List<UbicacionVerduras>.from(
        json.decode(str).map((x) => UbicacionVerduras.fromJson(x)));

class UbicacionVerduras {
  int? ubicacionVerduraId;
  int? ubicacionId;
  int? verduraId;

  UbicacionVerduras({
    this.ubicacionVerduraId,
    this.ubicacionId,
    this.verduraId,
  });

  factory UbicacionVerduras.fromJson(Map<String, dynamic> json) =>
      UbicacionVerduras(
        ubicacionVerduraId: json["UbicacionVerdura_id"],
        ubicacionId: json["Ubicacion_id"],
        verduraId: json["Verdura_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Verdura_id": verduraId,
      };
}
