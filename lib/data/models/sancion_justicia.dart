import 'dart:convert';

import 'package:ifasoris/domain/entities/sancion_justicia.dart';

List<SancionJusticiaModel> sancionesJusticiaFromJson(String str) =>
    List<SancionJusticiaModel>.from(
        json.decode(str).map((x) => SancionJusticiaModel.fromJson(x)));

class SancionJusticiaModel extends SancionJusticiaEntity {
  const SancionJusticiaModel({
    int? sancionJusticiaId,
    String? descripcion,
  }) : super(
          sancionJusticiaId: sancionJusticiaId,
          descripcion: descripcion,
        );

  static SancionJusticiaModel fromEntity(SancionJusticiaEntity entity) {
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
