// To parse this JSON data, do
//
//     final tuberculoPlatanoEntity = tuberculoPlatanoEntityFromJson(jsonString);

import 'dart:convert';

TuberculoPlatanoEntity tuberculoPlatanoEntityFromJson(String str) =>
    TuberculoPlatanoEntity.fromJson(json.decode(str));

String tuberculoPlatanoEntityToJson(TuberculoPlatanoEntity data) =>
    json.encode(data.toJson());

class TuberculoPlatanoEntity {
  TuberculoPlatanoEntity({
    required this.tuberculoPlatanoId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int tuberculoPlatanoId;
  String descripcion;
  int departamentoIde;

  factory TuberculoPlatanoEntity.fromJson(Map<String, dynamic> json) =>
      TuberculoPlatanoEntity(
        tuberculoPlatanoId: json["tuberculoPlatano_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "tuberculoPlatano_id": tuberculoPlatanoId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
