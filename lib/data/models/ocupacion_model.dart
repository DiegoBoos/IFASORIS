import 'dart:convert';

import '../../domain/entities/ocupacion_entity.dart';

List<OcupacionModel> ocupacionesFromJson(String str) =>
    List<OcupacionModel>.from(
        json.decode(str).map((x) => OcupacionModel.fromJson(x)));

class OcupacionModel extends OcupacionEntity {
  OcupacionModel({
    required int ocupacionId,
    required String descripcion,
  }) : super(
          ocupacionId: ocupacionId,
          descripcion: descripcion,
        );

  factory OcupacionModel.fromJson(Map<String, dynamic> json) => OcupacionModel(
        ocupacionId: json["Ocupacion_id"],
        descripcion: json["Descripcion"],
      );
}
