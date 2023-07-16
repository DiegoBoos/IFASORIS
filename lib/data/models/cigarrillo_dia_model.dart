import 'dart:convert';

import 'package:ifasoris/domain/entities/cigarrillo_dia_entity.dart';

List<CigarrilloDiaModel> cigarrillosDiaFromJson(String str) =>
    List<CigarrilloDiaModel>.from(
        json.decode(str).map((x) => CigarrilloDiaModel.fromJson(x)));

class CigarrilloDiaModel extends CigarrilloDiaEntity {
  CigarrilloDiaModel({
    required int numeroCigarrilloDiaId,
    required String descripcion,
  }) : super(
            numeroCigarrilloDiaId: numeroCigarrilloDiaId,
            descripcion: descripcion);

  factory CigarrilloDiaModel.fromJson(Map<String, dynamic> json) =>
      CigarrilloDiaModel(
        numeroCigarrilloDiaId: json["NumeroCigarrilloDia_id"],
        descripcion: json["Descripcion"],
      );
}
