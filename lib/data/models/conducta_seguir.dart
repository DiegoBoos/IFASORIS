import 'dart:convert';

import 'package:ifasoris/domain/entities/conducta_seguir.dart';

List<ConductaSeguirModel> conductasSeguirFromJson(String str) =>
    List<ConductaSeguirModel>.from(
        json.decode(str).map((x) => ConductaSeguirModel.fromJson(x)));

class ConductaSeguirModel extends ConductaSeguirEntity {
  const ConductaSeguirModel({
    int? conductaSeguirId,
    String? descripcion,
  });

  static ConductaSeguirModel fromEntity(ConductaSeguirEntity entity) {
    return ConductaSeguirModel(
      conductaSeguirId: entity.conductaSeguirId,
      descripcion: entity.descripcion,
    );
  }

  factory ConductaSeguirModel.fromJson(Map<String, dynamic> json) =>
      ConductaSeguirModel(
        conductaSeguirId: json["ConductaSeguir_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "ConductaSeguir_id": conductaSeguirId,
        "Descripcion": descripcion,
      };
}
