import 'dart:convert';

import 'package:ifasoris/data/models/cuidado_salud_cond_riesgo_model.dart';
import 'package:ifasoris/data/models/dim_ubicacion_model.dart';
import 'package:ifasoris/data/models/dim_vivienda_model.dart';
import 'package:ifasoris/data/models/dimension_sociocultural_pueblos_indigenas_model.dart';
import 'package:ifasoris/data/models/estilo_vida_saludable_model.dart';
import 'package:ifasoris/data/models/grupo_familiar_model.dart';
import 'package:ifasoris/domain/entities/atencion_salud_entity.dart';
import 'package:ifasoris/domain/entities/cuidado_salud_cond_riesgo_entity.dart';
import 'package:ifasoris/domain/entities/dim_ubicacion_entity.dart';
import 'package:ifasoris/domain/entities/dim_vivienda_entity.dart';
import 'package:ifasoris/domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import 'package:ifasoris/domain/entities/estilo_vida_saludable_entity.dart';
import 'package:ifasoris/domain/entities/grupo_familiar_entity.dart';

import '../../data/models/atencion_salud_model.dart';

class FamiliaEntity {
  int? familiaId;
  int? fichaId;
  String? apellidosFlia;
  int? fkAfiliadoId;
  DimViviendaEntity? vivienda;
  DimUbicacionEntity? ubicacion;
  List<GrupoFamiliarEntity>? grupoFamiliar;
  List<EstiloVidaSaludableEntity>? estiloVidaSaludable;
  List<CuidadoSaludCondRiesgoEntity>? cuidadoSaludCondRiesgo;
  List<DimensionSocioCulturalPueblosIndigenasEntity>?
      socioCulturalPueblosIndigenas;
  List<AtencionSaludEntity>? atencionSalud;

  FamiliaEntity({
    this.familiaId,
    this.fichaId,
    this.apellidosFlia,
    this.fkAfiliadoId,
    this.vivienda,
    this.ubicacion,
    this.grupoFamiliar,
    this.estiloVidaSaludable,
    this.cuidadoSaludCondRiesgo,
    this.socioCulturalPueblosIndigenas,
    this.atencionSalud,
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
      ubicacion: (json["ubicacion"] != null)
          ? DimUbicacionModel.fromJson(json["ubicacion"])
          : null,
      grupoFamiliar: (json["GrupoFamiliar"] != null)
          ? listGrupoFamiliarFromJson(jsonEncode(json["GrupoFamiliar"]))
          : null,
      estiloVidaSaludable: (json["EstilosVidaSaludable"] != null)
          ? listEstiloVidaSaludableFromJson(
              jsonEncode(json["EstilosVidaSaludable"]))
          : null,
      cuidadoSaludCondRiesgo: (json["CuidadoSaludCondRiesgo"] != null)
          ? listCuidadoSaludCondRiesgoFromJson(
              jsonEncode(json["CuidadoSaludCondRiesgo"]))
          : null,
      socioCulturalPueblosIndigenas:
          (json["SocioCulturalPueblosIndigenas"] != null)
              ? listDimensionSocioCulturalPueblosIndigenasFromJson(
                  jsonEncode(json["SocioCulturalPueblosIndigenas"]))
              : null,
      atencionSalud: (json["AtencionSalud"] != null)
          ? listAtencionSaludFromJson(jsonEncode(json["AtencionSalud"]))
          : null,
      // atencionSalud:
      //     (json["AtencionSalud"] != null) ? json["AtencionSalud"] : null,
    );
  }
}
