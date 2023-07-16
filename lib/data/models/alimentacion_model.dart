import 'dart:convert';

import 'package:ifasoris/domain/entities/alimentacion_entity.dart';

List<AlimentacionModel> alimentacionesFromJson(String str) =>
    List<AlimentacionModel>.from(
        json.decode(str).map((x) => AlimentacionModel.fromJson(x)));

class AlimentacionModel extends AlimentacionEntity {
  AlimentacionModel({
    required int alimentacionId,
    required String descripcion,
  }) : super(alimentacionId: alimentacionId, descripcion: descripcion);

  factory AlimentacionModel.fromJson(Map<String, dynamic> json) =>
      AlimentacionModel(
        alimentacionId: json["Alimentacion_id"],
        descripcion: json["Descripcion"],
      );
}
