import 'dart:convert';

import 'package:ifasoris/domain/entities/familia_entity.dart';

FamiliaModel familiaFromJson(String str) =>
    FamiliaModel.fromJson(json.decode(str));

class FamiliaModel extends FamiliaEntity {
  FamiliaModel({
    required int familiaId,
    required int fichaId,
    required String apellidosFlia,
    required int afiliadoId,
  }) : super(
          familiaId: familiaId,
          fichaId: fichaId,
          apellidosFlia: apellidosFlia,
          afiliadoId: afiliadoId,
        );

  factory FamiliaModel.fromJson(Map<String, dynamic> json) => FamiliaModel(
        familiaId: json["Familia_id"],
        fichaId: json["Ficha_id"],
        apellidosFlia: json["ApellidosFlia"],
        afiliadoId: json["Afiliado_id"],
      );
}
