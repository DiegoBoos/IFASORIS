import 'dart:convert';

import '../../domain/entities/parentesco.dart';

List<ParentescoModel> parentescosFromJson(String str) =>
    List<ParentescoModel>.from(
        json.decode(str).map((x) => ParentescoModel.fromJson(x)));

class ParentescoModel extends ParentescoEntity {
  const ParentescoModel({
    int? parentescoId,
    String? descripcion,
  });

  static ParentescoModel fromEntity(ParentescoEntity entity) {
    return ParentescoModel(
      parentescoId: entity.parentescoId,
      descripcion: entity.descripcion,
    );
  }

  factory ParentescoModel.fromJson(Map<String, dynamic> json) =>
      ParentescoModel(
        parentescoId: json["Parentesco_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Parentesco_id": parentescoId,
        "Descripcion": descripcion,
      };
}
