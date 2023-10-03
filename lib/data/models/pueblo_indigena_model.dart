// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import '../../domain/entities/pueblo_indigena_entity.dart';

List<PuebloIndigenaModel> pueblosIndigenasFromJson(String str) =>
    List<PuebloIndigenaModel>.from(
        json.decode(str).map((x) => PuebloIndigenaModel.fromJson(x)));

class PuebloIndigenaModel extends PuebloIndigenaEntity {
  PuebloIndigenaModel({
    required int puebloIde,
    required int Departamento_Ide,
    required String Descripcion,
  }) : super(
          puebloIde: puebloIde,
          Departamento_Ide: Departamento_Ide,
          Descripcion: Descripcion,
        );

  factory PuebloIndigenaModel.fromJson(Map<String, dynamic> json) =>
      PuebloIndigenaModel(
        puebloIde: json["Pueblo_ide"],
        Departamento_Ide: json["Departamento_Ide"],
        Descripcion: json["Descripcion"],
      );
}
