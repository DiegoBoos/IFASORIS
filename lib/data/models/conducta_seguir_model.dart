import 'dart:convert';

import 'package:ifasoris/domain/entities/conducta_seguir_entity.dart';

List<ConductaSeguirModel> conductasSeguirFromJson(String str) =>
    List<ConductaSeguirModel>.from(
        json.decode(str).map((x) => ConductaSeguirModel.fromJson(x)));

class ConductaSeguirModel extends ConductaSeguirEntity {
  ConductaSeguirModel({
    required int conductaSeguirId,
    required String descripcion,
  }) : super(conductaSeguirId: conductaSeguirId, descripcion: descripcion);

  factory ConductaSeguirModel.fromJson(Map<String, dynamic> json) =>
      ConductaSeguirModel(
        conductaSeguirId: json["ConductaSeguir_id"],
        descripcion: json["Descripcion"],
      );
}
