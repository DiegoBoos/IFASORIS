import 'dart:convert';

import 'package:ifasoris/domain/entities/sancion_justicia.dart';

List<SancionJusticiaModel> sancionesJusticiaFromJson(String str) =>
    List<SancionJusticiaModel>.from(
        json.decode(str).map((x) => SancionJusticiaModel.fromJson(x)));

class SancionJusticiaModel extends SancionJusticiaEntity {
  const SancionJusticiaModel({
    super.sancionJusticiaId,
    super.descripcion,
  });

  factory SancionJusticiaModel.fromEntity(SancionJusticiaEntity entity) {
    return SancionJusticiaModel(
      sancionJusticiaId: entity.sancionJusticiaId,
      descripcion: entity.descripcion,
    );
  }

  factory SancionJusticiaModel.fromJson(Map<String, dynamic> json) =>
      SancionJusticiaModel(
        sancionJusticiaId: json["SancionJusticia_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "SancionJusticia_id": sancionJusticiaId,
        "Descripcion": descripcion,
      };
}
