import 'dart:convert';

import '../../domain/entities/familia.dart';

FamiliaModel familiaFromJson(String str) =>
    FamiliaModel.fromJson(json.decode(str));

class FamiliaModel extends FamiliaEntity {
  const FamiliaModel({
    int? familiaId,
    int? fichaId,
    String? apellidosFlia,
    int? fkAfiliadoId,
  }) : super(
          familiaId: familiaId,
          fichaId: fichaId,
          apellidosFlia: apellidosFlia,
          fkAfiliadoId: fkAfiliadoId,
        );

  static FamiliaModel fromEntity(FamiliaEntity entity) {
    return FamiliaModel(
      familiaId: entity.familiaId,
      fichaId: entity.fichaId,
      apellidosFlia: entity.apellidosFlia,
      fkAfiliadoId: entity.fkAfiliadoId,
    );
  }

  factory FamiliaModel.fromJson(Map<String, dynamic> json) => FamiliaModel(
        familiaId: json["Familia_id"],
        fichaId: json["Ficha_id"],
        apellidosFlia: json["ApellidosFlia"],
        fkAfiliadoId: json["FK_Afiliado_id"],
      );

  Map<String, dynamic> toJson() => {
        "Familia_id": familiaId,
        "Ficha_id": fichaId,
        "ApellidosFlia": apellidosFlia,
        "FK_Afiliado_id": fkAfiliadoId,
      };

  Map<String, dynamic> toJsonSupabase() => {
        "Ficha_id": fichaId,
        "ApellidosFlia": apellidosFlia,
        "FK_Afiliado_id": fkAfiliadoId,
      };
}
