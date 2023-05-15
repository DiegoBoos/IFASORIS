import 'dart:convert';

import 'package:ifasoris/domain/entities/via_acceso_entity.dart';

List<ViaAccesoModel> viasAccesoFromJson(String str) =>
    List<ViaAccesoModel>.from(
        json.decode(str).map((x) => ViaAccesoModel.fromJson(x)));

class ViaAccesoModel extends ViaAccesoEntity {
  ViaAccesoModel({
    required int viaAccesoId,
    required String descripcion,
  }) : super(viaAccesoId: viaAccesoId, descripcion: descripcion);

  factory ViaAccesoModel.fromJson(Map<String, dynamic> json) => ViaAccesoModel(
        viaAccesoId: json["ViaAcceso_id"],
        descripcion: json["Descripcion"],
      );
}
