import 'package:ifasoris/data/models/dim_vivienda_model.dart';
import 'package:ifasoris/domain/entities/dim_vivienda_entity.dart';

class FamiliaEntity {
  int? familiaId;
  int? fichaId;
  String? apellidosFlia;
  int? fkAfiliadoId;
  DimViviendaEntity? vivienda;

  FamiliaEntity({
    this.familiaId,
    this.fichaId,
    this.apellidosFlia,
    this.fkAfiliadoId,
    this.vivienda,
  });

  FamiliaEntity copyWith({
    int? familiaId,
    int? fichaId,
    String? apellidosFlia,
    int? fkAfiliadoId,
  }) =>
      FamiliaEntity(
        familiaId: familiaId ?? this.familiaId,
        fichaId: fichaId ?? this.fichaId,
        apellidosFlia: apellidosFlia ?? this.apellidosFlia,
        fkAfiliadoId: fkAfiliadoId ?? this.fkAfiliadoId,
      );

  Map<String, dynamic> toJson() => {
        "Familia_id": familiaId,
        "Ficha_id": fichaId,
        "ApellidosFlia": apellidosFlia,
        "FK_Afiliado_id": fkAfiliadoId,
      };

  factory FamiliaEntity.fromJson(Map<String, dynamic> json) {
    return FamiliaEntity(
      familiaId: json["Familia_id"],
      fichaId: json["Ficha_id"],
      apellidosFlia: json["ApellidosFlia"],
      fkAfiliadoId: json["FK_Afiliado_id"],
      vivienda: (json["vivienda"] != null)
          ? DimViviendaModel.fromJson(json["vivienda"])
          : null,
    );
  }
}
