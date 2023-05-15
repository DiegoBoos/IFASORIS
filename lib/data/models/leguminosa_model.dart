import 'dart:convert';

import '../../domain/entities/leguminosa_entity.dart';

List<LeguminosaModel> leguminosasFromJson(String str) =>
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
        leguminosaId: json["Leguminosa_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
