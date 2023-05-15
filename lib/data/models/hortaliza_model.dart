import 'dart:convert';

import 'package:ifasoris/domain/entities/hortaliza_entity.dart';

List<HortalizaModel> hortalizasFromJson(String str) =>
    List<HortalizaModel>.from(
        json.decode(str).map((x) => HortalizaModel.fromJson(x)));

class HortalizaModel extends HortalizaEntity {
  HortalizaModel({
    required int hortalizaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          hortalizaId: hortalizaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory HortalizaModel.fromJson(Map<String, dynamic> json) => HortalizaModel(
        hortalizaId: json["Hortaliza_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
