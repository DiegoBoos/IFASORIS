// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import '../../domain/entities/pueblo_indigena.dart';

List<PuebloIndigenaModel> pueblosIndigenasFromJson(String str) =>
    List<PuebloIndigenaModel>.from(
        json.decode(str).map((x) => PuebloIndigenaModel.fromJson(x)));

class PuebloIndigenaModel extends PuebloIndigenaEntity {
  const PuebloIndigenaModel({
    int? puebloIde,
    int? departamentoIde,
    String? descripcion,
  }) : super(
          puebloIde: puebloIde,
          departamentoIde: departamentoIde,
          descripcion: descripcion,
        );

  static PuebloIndigenaModel fromEntity(PuebloIndigenaEntity entity) {
    return PuebloIndigenaModel(
      puebloIde: entity.puebloIde,
      departamentoIde: entity.departamentoIde,
      descripcion: entity.descripcion,
    );
  }

  factory PuebloIndigenaModel.fromJson(Map<String, dynamic> json) =>
      PuebloIndigenaModel(
        puebloIde: json["Pueblo_ide"],
        departamentoIde: json["Departamento_Ide"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Pueblo_ide": puebloIde,
        "Departamento_Ide": departamentoIde,
        "Descripcion": descripcion,
      };
}
