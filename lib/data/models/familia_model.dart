import 'dart:convert';

import 'package:ifasoris/domain/entities/familia_entity.dart';

FamiliaModel familiaModelFromJson(String str) =>
    FamiliaModel.fromJson(json.decode(str));

class FamiliaModel extends FamiliaEntity {
  FamiliaModel({
    required int fichaId,
    required String apellidosFlia,
    required int afiliadoId,
  }) : super(
          fichaId: fichaId,
          apellidosFlia: apellidosFlia,
          afiliadoId: afiliadoId,
        );

  factory FamiliaModel.fromJson(Map<String, dynamic> json) => FamiliaModel(
        fichaId: json["Ficha_id"],
        apellidosFlia: json["ApellidosFlia"],
        afiliadoId: json["Afiliado_id"],
      );
}
