import 'dart:convert';

import 'package:ifasoris/domain/entities/familia_entity.dart';

import 'dim_vivienda_model.dart';

FamiliaModel familiaFromJson(String str) =>
    FamiliaModel.fromJson(json.decode(str));

class FamiliaModel extends FamiliaEntity {
  FamiliaModel({
    required int familiaId,
    required int fichaId,
    required String apellidosFlia,
    required int fkAfiliadoId,
    DimViviendaModel? vivienda,
  }) : super(
          familiaId: familiaId,
          fichaId: fichaId,
          apellidosFlia: apellidosFlia,
          fkAfiliadoId: fkAfiliadoId,
          vivienda: vivienda
        );

  factory FamiliaModel.fromJson(Map<String, dynamic> json) => FamiliaModel(
        familiaId: json["Familia_id"],
        fichaId: json["Ficha_id"],
        apellidosFlia: json["ApellidosFlia"],
        fkAfiliadoId: json["FK_Afiliado_id"],
        vivienda: (json["vivienda"] != null)
            ? DimViviendaModel.fromJson(json["vivienda"])
            : null,
      );
}
