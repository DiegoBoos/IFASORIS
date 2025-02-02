import 'dart:convert';

import 'package:ifasoris/domain/entities/via_acceso.dart';

List<ViaAccesoModel> viasAccesoFromJson(String str) =>
    List<ViaAccesoModel>.from(
        json.decode(str).map((x) => ViaAccesoModel.fromJson(x)));

class ViaAccesoModel extends ViaAccesoEntity {
  const ViaAccesoModel({
    super.viaAccesoId,
    super.descripcion,
  });

  factory ViaAccesoModel.fromEntity(ViaAccesoEntity entity) {
    return ViaAccesoModel(
      viaAccesoId: entity.viaAccesoId,
      descripcion: entity.descripcion,
    );
  }

  factory ViaAccesoModel.fromJson(Map<String, dynamic> json) => ViaAccesoModel(
        viaAccesoId: json["ViaAcceso_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "ViaAcceso_id": viaAccesoId,
        "Descripcion": descripcion,
      };
}
