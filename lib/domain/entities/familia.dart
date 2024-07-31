import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/entities/atencion_salud.dart';
import 'package:ifasoris/domain/entities/cuidado_salud_cond_riesgo.dart';
import 'package:ifasoris/domain/entities/dim_ubicacion.dart';
import 'package:ifasoris/domain/entities/dim_vivienda.dart';
import 'package:ifasoris/domain/entities/dimension_sociocultural_pueblos_indigenas.dart';
import 'package:ifasoris/domain/entities/estilo_vida_saludable.dart';
import 'package:ifasoris/domain/entities/grupo_familiar.dart';

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
