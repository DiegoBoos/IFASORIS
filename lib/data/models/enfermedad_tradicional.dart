import 'dart:convert';

import 'package:ifasoris/domain/entities/enfermedad_tradicional.dart';

List<EnfermedadTradicionalModel> enfermedadesTradicionalesFromJson(
        String str) =>
    List<EnfermedadTradicionalModel>.from(
        json.decode(str).map((x) => EnfermedadTradicionalModel.fromJson(x)));

class EnfermedadTradicionalModel extends EnfermedadTradicionalEntity {
  const EnfermedadTradicionalModel(
      {int? enfermedadTradicionalId, String? descripcion, int? departamentoId})
      : super(
            enfermedadTradicionalId: enfermedadTradicionalId,
            descripcion: descripcion,
            departamentoId: departamentoId);

  static EnfermedadTradicionalModel fromEntity(
      EnfermedadTradicionalEntity entity) {
    return EnfermedadTradicionalModel(
        enfermedadTradicionalId: entity.enfermedadTradicionalId,
        descripcion: entity.descripcion,
        departamentoId: entity.departamentoId);
  }

  factory EnfermedadTradicionalModel.fromJson(Map<String, dynamic> json) =>
      EnfermedadTradicionalModel(
        enfermedadTradicionalId: json["EnfermedadTradicional_id"],
        descripcion: json["Descripcion"],
        departamentoId: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "EnfermedadTradicional_id": enfermedadTradicionalId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoId
      };
}

class LstEnfermedadTradicional {
  int? atencionSaludId;
  int? enfermedadTradicionalId;

  LstEnfermedadTradicional({
    this.atencionSaludId,
    this.enfermedadTradicionalId,
  });

  factory LstEnfermedadTradicional.fromJson(Map<String, dynamic> json) =>
      LstEnfermedadTradicional(
        enfermedadTradicionalId: json["EnfermedadTradicional_id"],
      );

  Map<String, dynamic> toJson() => {
        "AtencionSalud_id": atencionSaludId,
        "EnfermedadTradicional_id": enfermedadTradicionalId,
      };
}

List<LstEnfermedadTradicional> listEnfermedadTradicionalFromJson(String str) =>
    List<LstEnfermedadTradicional>.from(
        json.decode(str).map((x) => LstEnfermedadTradicional.fromJson(x)));

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
