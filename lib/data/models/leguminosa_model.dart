import 'dart:convert';

import '../../domain/entities/leguminosa_entity.dart';

List<LeguminosaModel> leguminosasModelFromJson(String str) =>
    List<LeguminosaModel>.from(
        json.decode(str).map((x) => LeguminosaModel.fromJson(x)));

class LeguminosaModel extends LeguminosaEntity {
  LeguminosaModel({
    required int leguminosaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          leguminosaId: leguminosaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory LeguminosaModel.fromJson(Map<String, dynamic> json) =>
      LeguminosaModel(
        leguminosaId: json["leguminosa_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "leguminosa_id": leguminosaId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
