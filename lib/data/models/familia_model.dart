import 'dart:convert';

import 'package:ifasoris/domain/entities/familia_entity.dart';

FamiliaModel familiaFromJson(String str) =>
    FamiliaModel.fromJson(json.decode(str));

class FamiliaModel extends FamiliaEntity {
  FamiliaModel({
    required int familiaId,
    required int fichaId,
    required String apellidosFlia,
    required int fkAfiliadoId,
  }) : super(
          familiaId: familiaId,
          fichaId: fichaId,
          apellidosFlia: apellidosFlia,
          fkAfiliadoId: fkAfiliadoId,
        );

  factory FamiliaModel.fromJson(Map<String, dynamic> json) => FamiliaModel(
        familiaId: json["Familia_id"],
        fichaId: json["Ficha_id"],
        apellidosFlia: json["ApellidosFlia"],
        fkAfiliadoId: json["FK_Afiliado_id"],
      );
}
