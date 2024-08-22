import 'dart:convert';

import 'package:ifasoris/domain/entities/via_acceso.dart';

List<ViaAccesoModel> viasAccesoFromJson(String str) =>
    List<ViaAccesoModel>.from(
        json.decode(str).map((x) => ViaAccesoModel.fromJson(x)));

class ViaAccesoModel extends ViaAccesoEntity {
  const ViaAccesoModel({
    int? viaAccesoId,
    String? descripcion,
    int? departamentoId,
  }) : super(
          viaAccesoId: viaAccesoId,
          descripcion: descripcion,
          departamentoId: departamentoId,
        );

  static ViaAccesoModel fromEntity(ViaAccesoEntity entity) {
    return ViaAccesoModel(
      viaAccesoId: entity.viaAccesoId,
      descripcion: entity.descripcion,
      departamentoId: entity.departamentoId,
    );
  }

  factory ViaAccesoModel.fromJson(Map<String, dynamic> json) => ViaAccesoModel(
        viaAccesoId: json["ViaAcceso_id"],
        descripcion: json["Descripcion"],
        departamentoId: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "ViaAcceso_id": viaAccesoId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoId
      };
}
