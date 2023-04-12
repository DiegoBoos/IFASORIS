import 'dart:convert';

import 'package:ifasoris/domain/entities/verdura_entity.dart';

List<VerduraModel> verdurasModelFromJson(String str) => List<VerduraModel>.from(
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
        verduraId: json["verdura_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "verdura_id": verduraId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
