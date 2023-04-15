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
        frutoId: json["Fruto_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
