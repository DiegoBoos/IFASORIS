import 'dart:convert';

import 'package:ifasoris/domain/entities/sancion_justicia_entity.dart';

List<SancionJusticiaModel> sancionesJusticiaFromJson(String str) =>
    List<SancionJusticiaModel>.from(
        json.decode(str).map((x) => SancionJusticiaModel.fromJson(x)));

class SancionJusticiaModel extends SancionJusticiaEntity {
  SancionJusticiaModel({
    required int sancionJusticiaId,
    required String descripcion,
  }) : super(sancionJusticiaId: sancionJusticiaId, descripcion: descripcion);

  factory SancionJusticiaModel.fromJson(Map<String, dynamic> json) =>
      SancionJusticiaModel(
        sancionJusticiaId: json["SancionJusticia_id"],
        descripcion: json["Descripcion"],
      );
}
