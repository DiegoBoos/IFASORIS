import 'package:equatable/equatable.dart';

import 'atencion_salud.dart';
import 'cuidado_salud_cond_riesgo.dart';
import 'dim_ubicacion.dart';
import 'dim_vivienda.dart';
import 'dimension_sociocultural_pueblos_indigenas.dart';
import 'estilo_vida_saludable.dart';
import 'grupo_familiar.dart';

class FamiliaEntity extends Equatable {
  final int? familiaId;
  final int? fichaId;
  final String? apellidosFlia;
  final int? fkAfiliadoId;
  final DimViviendaEntity? vivienda;
  final DimUbicacionEntity? ubicacion;
  final List<GrupoFamiliarEntity>? grupoFamiliar;
  final List<EstiloVidaSaludableEntity>? estiloVidaSaludable;
  final List<CuidadoSaludCondRiesgoEntity>? cuidadoSaludCondRiesgo;
  final List<DimensionSocioCulturalPueblosIndigenasEntity>?
      socioCulturalPueblosIndigenas;
  final List<AtencionSaludEntity>? atencionSalud;

  const FamiliaEntity({
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

  @override
  List<Object?> get props => [
        familiaId,
        fichaId,
        apellidosFlia,
        fkAfiliadoId,
        vivienda,
        ubicacion,
        grupoFamiliar,
        estiloVidaSaludable,
        cuidadoSaludCondRiesgo,
        socioCulturalPueblosIndigenas,
        atencionSalud,
      ];
}
