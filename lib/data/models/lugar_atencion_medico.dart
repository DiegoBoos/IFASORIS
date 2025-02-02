import 'dart:convert';

import 'package:ifasoris/domain/entities/lugar_atencion_medico.dart';

List<LugarAtencionMedicoModel> lugaresAtencionMedicoFromJson(String str) =>
    List<LugarAtencionMedicoModel>.from(
        json.decode(str).map((x) => LugarAtencionMedicoModel.fromJson(x)));

class LugarAtencionMedicoModel extends LugarAtencionMedicoEntity {
  const LugarAtencionMedicoModel({
    super.lugarAtencionMedicoId,
    super.descripcion,
  });

  factory LugarAtencionMedicoModel.fromEntity(
      LugarAtencionMedicoEntity entity) {
    return LugarAtencionMedicoModel(
      lugarAtencionMedicoId: entity.lugarAtencionMedicoId,
      descripcion: entity.descripcion,
    );
  }

  factory LugarAtencionMedicoModel.fromJson(Map<String, dynamic> json) =>
      LugarAtencionMedicoModel(
        lugarAtencionMedicoId: json["LugarAtencionMedico_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "LugarAtencionMedico_id": lugarAtencionMedicoId,
        "Descripcion": descripcion,
      };
}

class LstLugarAtencionMedico {
  int? atencionSaludId;
  int? lugarAtencionMedicoId;

  LstLugarAtencionMedico({
    this.atencionSaludId,
    this.lugarAtencionMedicoId,
  });

  factory LstLugarAtencionMedico.fromJson(Map<String, dynamic> json) =>
      LstLugarAtencionMedico(
        lugarAtencionMedicoId: json["LugarAtencionMedico_id"],
      );

  Map<String, dynamic> toJson() => {
        "AtencionSalud_id": atencionSaludId,
        "LugarAtencionMedico_id": lugarAtencionMedicoId,
      };
}

List<LstLugarAtencionMedico> listLugarAtencionFromJson(String str) =>
    List<LstLugarAtencionMedico>.from(
        json.decode(str).map((x) => LstLugarAtencionMedico.fromJson(x)));

List<LugarAtencionMedicoAtencionSalud> lugarAtencionMedicoAtencionSaludFromJson(
        String str) =>
    List<LugarAtencionMedicoAtencionSalud>.from(json
        .decode(str)
        .map((x) => LugarAtencionMedicoAtencionSalud.fromJson(x)));

class LugarAtencionMedicoAtencionSalud {
  int? lugarAtencionAtencionSaludId;
  int? atencionSaludId;
  int? lugarAtencionMedicoId;

  LugarAtencionMedicoAtencionSalud({
    this.lugarAtencionAtencionSaludId,
    this.atencionSaludId,
    this.lugarAtencionMedicoId,
  });

  factory LugarAtencionMedicoAtencionSalud.fromJson(
          Map<String, dynamic> json) =>
      LugarAtencionMedicoAtencionSalud(
        lugarAtencionAtencionSaludId: json["LugaresAtencionAtencionSalud_id"],
        atencionSaludId: json["AtencionSalud_id"],
        lugarAtencionMedicoId: json["LugarAtencionMedico_id"],
      );

  Map<String, dynamic> toJson() => {
        "AtencionSalud_id": atencionSaludId,
        "LugarAtencionMedico_id": lugarAtencionMedicoId,
      };
}
