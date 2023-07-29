import 'dart:convert';

import 'package:ifasoris/domain/entities/lugar_atencion_medico_entity.dart';

List<LugarAtencionMedicoModel> lugaresAtencionMedicoFromJson(String str) =>
    List<LugarAtencionMedicoModel>.from(
        json.decode(str).map((x) => LugarAtencionMedicoModel.fromJson(x)));

class LugarAtencionMedicoModel extends LugarAtencionMedicoEntity {
  LugarAtencionMedicoModel({
    required int lugarAtencionMedicoId,
    required String descripcion,
  }) : super(
            lugarAtencionMedicoId: lugarAtencionMedicoId,
            descripcion: descripcion);

  factory LugarAtencionMedicoModel.fromJson(Map<String, dynamic> json) =>
      LugarAtencionMedicoModel(
        lugarAtencionMedicoId: json["LugarAtencionMedico_id"],
        descripcion: json["Descripcion"],
      );
}

class LstLugarAtencionMedico {
  int? lugarAtencionMedicoId;

  LstLugarAtencionMedico({
    this.lugarAtencionMedicoId,
  });

  factory LstLugarAtencionMedico.fromJson(Map<String, dynamic> json) =>
      LstLugarAtencionMedico(
        lugarAtencionMedicoId: json["LugarAtencionMedico_id"],
      );

  Map<String, dynamic> toJson() => {
        "LugarAtencionMedico_id": lugarAtencionMedicoId,
      };
}

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
