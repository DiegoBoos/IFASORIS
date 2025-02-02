import 'dart:convert';

import 'package:ifasoris/domain/entities/familia.dart';

import 'dim_vivienda.dart';

FamiliaModel familiaFromJson(String str) =>
    FamiliaModel.fromJson(json.decode(str));

class FamiliaModel extends FamiliaEntity {
  const FamiliaModel({
    super.familiaId,
    super.fichaId,
    super.apellidosFlia,
    super.fkAfiliadoId,
    DimViviendaModel? super.vivienda,
  });

  factory FamiliaModel.fromEntity(FamiliaEntity entity) {
    return FamiliaModel(
      familiaId: entity.familiaId,
      fichaId: entity.fichaId,
      apellidosFlia: entity.apellidosFlia,
      fkAfiliadoId: entity.fkAfiliadoId,
      vivienda: (entity.vivienda != null)
          ? DimViviendaModel.fromEntity(entity.vivienda!)
          : null,
    );
  }

  factory FamiliaModel.fromJson(Map<String, dynamic> json) => FamiliaModel(
        familiaId: json["Familia_id"],
        fichaId: json["Ficha_id"],
        apellidosFlia: json["ApellidosFlia"],
        fkAfiliadoId: json["FK_Afiliado_id"],
        vivienda: (json["vivienda"] != null)
            ? DimViviendaModel.fromJson(json["vivienda"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "Familia_id": familiaId,
        "Ficha_id": fichaId,
        "ApellidosFlia": apellidosFlia,
        "FK_Afiliado_id": fkAfiliadoId,
      };

  FamiliaModel copyWith({
    int? familiaId,
    int? fichaId,
    String? apellidosFlia,
    int? fkAfiliadoId,
  }) =>
      FamiliaModel(
        familiaId: familiaId ?? this.familiaId,
        fichaId: fichaId ?? this.fichaId,
        apellidosFlia: apellidosFlia ?? this.apellidosFlia,
        fkAfiliadoId: fkAfiliadoId ?? this.fkAfiliadoId,
      );
}
