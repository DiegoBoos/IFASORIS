import 'dart:convert';

import '../../domain/entities/cereal_entity.dart';

List<CerealModel> cerealesModelFromJson(String str) => List<CerealModel>.from(
    json.decode(str).map((x) => CerealModel.fromJson(x)));

class CerealModel extends CerealEntity {
  CerealModel({
    required int cerealId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          cerealId: cerealId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory CerealModel.fromJson(Map<String, dynamic> json) => CerealModel(
        cerealId: json["cereal_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "cereal_id": cerealId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
