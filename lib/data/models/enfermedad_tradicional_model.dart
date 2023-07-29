import 'dart:convert';

import 'package:ifasoris/domain/entities/enfermedad_tradicional_entity.dart';

List<EnfermedadTradicionalModel> enfermedadesTradicionalesFromJson(
        String str) =>
    List<EnfermedadTradicionalModel>.from(
        json.decode(str).map((x) => EnfermedadTradicionalModel.fromJson(x)));

class EnfermedadTradicionalModel extends EnfermedadTradicionalEntity {
  EnfermedadTradicionalModel({
    required int enfermedadTradicionalId,
    required String descripcion,
  }) : super(
            enfermedadTradicionalId: enfermedadTradicionalId,
            descripcion: descripcion);

  factory EnfermedadTradicionalModel.fromJson(Map<String, dynamic> json) =>
      EnfermedadTradicionalModel(
        enfermedadTradicionalId: json["EnfermedadTradicional_id"],
        descripcion: json["Descripcion"],
      );
}

class LstEnfermedadTradicional {
  int? enfermedadTradicionalId;

  LstEnfermedadTradicional({
    this.enfermedadTradicionalId,
  });

  factory LstEnfermedadTradicional.fromJson(Map<String, dynamic> json) =>
      LstEnfermedadTradicional(
        enfermedadTradicionalId: json["EnfermedadTradicional_id"],
      );

  Map<String, dynamic> toJson() => {
        "EnfermedadTradicional_id": enfermedadTradicionalId,
      };
}

List<EnfermedadTradicionalAtencionSalud>
    enfermedadesTradicionalesAtencionSaludFromJson(String str) =>
        List<EnfermedadTradicionalAtencionSalud>.from(json
            .decode(str)
            .map((x) => EnfermedadTradicionalAtencionSalud.fromJson(x)));

class EnfermedadTradicionalAtencionSalud {
  int? enfermedadTradicionalAtencionSaludId;
  int? atencionSaludId;
  int? enfermedadTradicionalId;

  EnfermedadTradicionalAtencionSalud({
    this.enfermedadTradicionalAtencionSaludId,
    this.atencionSaludId,
    this.enfermedadTradicionalId,
  });

  factory EnfermedadTradicionalAtencionSalud.fromJson(
          Map<String, dynamic> json) =>
      EnfermedadTradicionalAtencionSalud(
        enfermedadTradicionalAtencionSaludId:
            json["EnfermedadesTradicionales_AtencionSalud_id"],
        atencionSaludId: json["AtencionSalud_id"],
        enfermedadTradicionalId: json["EnfermedadTradicional_id"],
      );

  Map<String, dynamic> toJson() => {
        "AtencionSalud_id": atencionSaludId,
        "EnfermedadTradicional_id": enfermedadTradicionalId,
      };
}
