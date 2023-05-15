import 'dart:convert';

import 'package:ifasoris/domain/entities/verdura_entity.dart';

List<VerduraModel> verdurasFromJson(String str) => List<VerduraModel>.from(
    json.decode(str).map((x) => VerduraModel.fromJson(x)));

class VerduraModel extends VerduraEntity {
  VerduraModel({
    required int verduraId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          verduraId: verduraId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory VerduraModel.fromJson(Map<String, dynamic> json) => VerduraModel(
        verduraId: json["Verdura_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
