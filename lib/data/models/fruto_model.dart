import 'dart:convert';

import 'package:ifasoris/domain/entities/fruto_entity.dart';

List<FrutoModel> frutosModelFromJson(String str) =>
    List<FrutoModel>.from(json.decode(str).map((x) => FrutoModel.fromJson(x)));

class FrutoModel extends FrutoEntity {
  FrutoModel({
    required int frutoId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          frutoId: frutoId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory FrutoModel.fromJson(Map<String, dynamic> json) => FrutoModel(
        frutoId: json["fruto_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "fruto_id": frutoId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
