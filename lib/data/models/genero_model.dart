import 'dart:convert';

import '../../domain/entities/genero_entity.dart';

List<GeneroModel> generosFromJson(String str) => List<GeneroModel>.from(
    json.decode(str).map((x) => GeneroModel.fromJson(x)));

class GeneroModel extends GeneroEntity {
  GeneroModel({
    required int generoId,
    required String tipo,
    required String descripcion,
  }) : super(
          generoId: generoId,
          tipo: tipo,
          descripcion: descripcion,
        );

  factory GeneroModel.fromJson(Map<String, dynamic> json) => GeneroModel(
        generoId: json["Genero_id"],
        tipo: json["Tipo"],
        descripcion: json["Descripcion"],
      );
}
