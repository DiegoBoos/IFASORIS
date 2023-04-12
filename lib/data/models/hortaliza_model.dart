import 'dart:convert';

import 'package:ifasoris/domain/entities/hortaliza_entity.dart';

List<HortalizaModel> hortalizasModelFromJson(String str) =>
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
        hortalizaId: json["hortaliza_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "hortaliza_id": hortalizaId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
