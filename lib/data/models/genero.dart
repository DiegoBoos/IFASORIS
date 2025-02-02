import 'dart:convert';

import '../../domain/entities/genero.dart';

List<GeneroModel> generosFromJson(String str) => List<GeneroModel>.from(
    json.decode(str).map((x) => GeneroModel.fromJson(x)));

class GeneroModel extends GeneroEntity {
  const GeneroModel({
    super.generoId,
    super.tipo,
    super.descripcion,
  });

  factory GeneroModel.fromEntity(GeneroEntity entity) {
    return GeneroModel(
      generoId: entity.generoId,
      tipo: entity.tipo,
      descripcion: entity.descripcion,
    );
  }

  factory GeneroModel.fromJson(Map<String, dynamic> json) => GeneroModel(
        generoId: json["Genero_id"],
        tipo: json["Tipo"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Genero_id": generoId,
        "Tipo": tipo,
        "Descripcion": descripcion,
      };
}
