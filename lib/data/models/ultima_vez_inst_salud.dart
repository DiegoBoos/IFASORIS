import 'dart:convert';

import 'package:ifasoris/domain/entities/ultima_vez_inst_salud.dart';

List<UltimaVezInstSaludModel> ultimasVecesInstSaludFromJson(String str) =>
    List<UltimaVezInstSaludModel>.from(
        json.decode(str).map((x) => UltimaVezInstSaludModel.fromJson(x)));

class UltimaVezInstSaludModel extends UltimaVezInstSaludEntity {
  const UltimaVezInstSaludModel({
    int? ultimaVezInstSaludId,
    String? descripcion,
  }) : super(
          ultimaVezInstSaludId: ultimaVezInstSaludId,
          descripcion: descripcion,
        );

  static UltimaVezInstSaludModel fromEntity(UltimaVezInstSaludEntity entity) {
    return UltimaVezInstSaludModel(
      ultimaVezInstSaludId: entity.ultimaVezInstSaludId,
      descripcion: entity.descripcion,
    );
  }

  factory UltimaVezInstSaludModel.fromJson(Map<String, dynamic> json) =>
      UltimaVezInstSaludModel(
        ultimaVezInstSaludId: json["UltimaVezInstSalud_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "UltimaVezInstSalud_id": ultimaVezInstSaludId,
        "Descripcion": descripcion,
      };
}
