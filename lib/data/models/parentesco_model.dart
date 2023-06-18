import 'dart:convert';

import '../../domain/entities/parentesco_entity.dart';

List<ParentescoModel> parentescosFromJson(String str) =>
    List<ParentescoModel>.from(
        json.decode(str).map((x) => ParentescoModel.fromJson(x)));

class ParentescoModel extends ParentescoEntity {
  ParentescoModel({
    required int parentescoId,
    required String descripcion,
  }) : super(
          parentescoId: parentescoId,
          descripcion: descripcion,
        );

  factory ParentescoModel.fromJson(Map<String, dynamic> json) =>
      ParentescoModel(
        parentescoId: json["Parentesco_id"],
        descripcion: json["Descripcion"],
      );
}
