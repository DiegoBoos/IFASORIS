import 'dart:convert';

import 'package:ifasoris/domain/entities/verdura.dart';

List<VerduraModel> verdurasFromJson(String str) => List<VerduraModel>.from(
    json.decode(str).map((x) => VerduraModel.fromJson(x)));

class VerduraModel extends VerduraEntity {
  const VerduraModel({
    int? verduraId,
    String? descripcion,
    int? departamentoIde,
  }) : super(
          verduraId: verduraId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  static VerduraModel fromEntity(VerduraEntity entity) {
    return VerduraModel(
      verduraId: entity.verduraId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory VerduraModel.fromJson(Map<String, dynamic> json) => VerduraModel(
        verduraId: json["Verdura_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "Verdura_id": verduraId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstVerdura {
  int? ubicacionId;
  int? verduraId;
  String? otroVerdura;

  LstVerdura({
    this.ubicacionId,
    this.verduraId,
    this.otroVerdura,
  });

  factory LstVerdura.fromJson(Map<String, dynamic> json) => LstVerdura(
        verduraId: json["Verdura_id"],
        otroVerdura: json["OtroVerdura"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Verdura_id": verduraId,
        "OtroVerdura": otroVerdura,
      };
}

List<UbicacionVerduras> ubicacionVerdurasFromJson(String str) =>
    List<UbicacionVerduras>.from(
        json.decode(str).map((x) => UbicacionVerduras.fromJson(x)));

class UbicacionVerduras {
  int? ubicacionVerduraId;
  int? ubicacionId;
  int? verduraId;
  String? otroVerdura;

  UbicacionVerduras({
    this.ubicacionVerduraId,
    this.ubicacionId,
    this.verduraId,
    this.otroVerdura,
  });

  factory UbicacionVerduras.fromJson(Map<String, dynamic> json) =>
      UbicacionVerduras(
        ubicacionVerduraId: json["UbicacionVerdura_id"],
        ubicacionId: json["Ubicacion_id"],
        verduraId: json["Verdura_id"],
        otroVerdura: json["OtroVerdura"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Verdura_id": verduraId,
        "OtroVerdura": otroVerdura,
      };
}
