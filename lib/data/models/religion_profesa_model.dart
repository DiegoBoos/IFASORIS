import 'dart:convert';

import 'package:ifasoris/domain/entities/religion_profesa_entity.dart';

List<ReligionProfesaModel> religionesProfesaFromJson(String str) =>
    List<ReligionProfesaModel>.from(
        json.decode(str).map((x) => ReligionProfesaModel.fromJson(x)));

class ReligionProfesaModel extends ReligionProfesaEntity {
  ReligionProfesaModel({
    required int religionProfesaId,
    required String descripcion,
  }) : super(religionProfesaId: religionProfesaId, descripcion: descripcion);

  factory ReligionProfesaModel.fromJson(Map<String, dynamic> json) =>
      ReligionProfesaModel(
        religionProfesaId: json["ReligionProfesa_id"],
        descripcion: json["Descripcion"],
      );
}
