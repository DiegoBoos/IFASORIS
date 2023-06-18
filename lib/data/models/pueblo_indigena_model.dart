import 'dart:convert';

import '../../domain/entities/pueblo_indigena_entity.dart';

List<PuebloIndigenaModel> pueblosIndigenasFromJson(String str) =>
    List<PuebloIndigenaModel>.from(
        json.decode(str).map((x) => PuebloIndigenaModel.fromJson(x)));

class PuebloIndigenaModel extends PuebloIndigenaEntity {
  PuebloIndigenaModel({
    required int puebloIndigenaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          puebloIndigenaId: puebloIndigenaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory PuebloIndigenaModel.fromJson(Map<String, dynamic> json) =>
      PuebloIndigenaModel(
        puebloIndigenaId: json["PuebloIndigena_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
