import 'package:equatable/equatable.dart';

import '../../data/models/nombre_enfermedad.dart';
import '../../data/models/servicio_solicitado.dart';
import '../../ui/blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';

class CuidadoSaludCondRiesgoEntity extends Equatable {
  final int? cuidadoSaludCondRiesgoId;
  final int? afiliadoId;
  final int? familiaId;
  final int? ultimaVezInstSaludId;
  final int? seguimientoEnfermedadId;
  final int? condicionNutricionalId;
  final int? tosFlemaId;
  final int? manchasPielId;
  final int? carnetVacunacionId;
  final int? esquemaVacunacionId;
  final int? lugarVacunacionId;
  final int? utilizaMetodoPlanificacionId;
  final int? metodoPlanificacionId;
  final int? conductaSeguirId;
  final List<LstServicioSolicitado>? lstServiciosSolicitados;
  final List<LstNombreEnfermedad>? lstNombresEnfermedades;
  final CuidadoSaludCondRiesgoState formStatus;

  const CuidadoSaludCondRiesgoEntity({
    this.cuidadoSaludCondRiesgoId,
    this.afiliadoId,
    this.familiaId,
    this.ultimaVezInstSaludId,
    this.seguimientoEnfermedadId,
    this.condicionNutricionalId,
    this.tosFlemaId,
    this.manchasPielId,
    this.carnetVacunacionId,
    this.esquemaVacunacionId,
    this.lugarVacunacionId,
    this.utilizaMetodoPlanificacionId,
    this.metodoPlanificacionId,
    this.conductaSeguirId,
    this.lstServiciosSolicitados,
    this.lstNombresEnfermedades,
    this.formStatus = const CuidadoSaludCondRiesgoFormInitial(),
  });

  CuidadoSaludCondRiesgoEntity copyWith({
    int? cuidadoSaludCondRiesgoId,
    int? afiliadoId,
    int? familiaId,
    int? ultimaVezInstSaludId,
    int? seguimientoEnfermedadId,
    int? condicionNutricionalId,
    int? tosFlemaId,
    int? manchasPielId,
    int? carnetVacunacionId,
    int? esquemaVacunacionId,
    int? lugarVacunacionId,
    int? utilizaMetodoPlanificacionId,
    int? metodoPlanificacionId,
    int? conductaSeguirId,
    List<LstServicioSolicitado>? lstServiciosSolicitados,
    List<LstNombreEnfermedad>? lstNombresEnfermedades,
    CuidadoSaludCondRiesgoState? formStatus,
  }) =>
      CuidadoSaludCondRiesgoEntity(
        cuidadoSaludCondRiesgoId:
            cuidadoSaludCondRiesgoId ?? this.cuidadoSaludCondRiesgoId,
        afiliadoId: afiliadoId ?? this.afiliadoId,
        familiaId: familiaId ?? this.familiaId,
        ultimaVezInstSaludId: ultimaVezInstSaludId ?? this.ultimaVezInstSaludId,
        seguimientoEnfermedadId:
            seguimientoEnfermedadId ?? this.seguimientoEnfermedadId,
        condicionNutricionalId:
            condicionNutricionalId ?? this.condicionNutricionalId,
        tosFlemaId: tosFlemaId ?? this.tosFlemaId,
        manchasPielId: manchasPielId ?? this.manchasPielId,
        carnetVacunacionId: carnetVacunacionId ?? this.carnetVacunacionId,
        esquemaVacunacionId: esquemaVacunacionId ?? this.esquemaVacunacionId,
        lugarVacunacionId: lugarVacunacionId ?? this.lugarVacunacionId,
        utilizaMetodoPlanificacionId:
            utilizaMetodoPlanificacionId ?? this.utilizaMetodoPlanificacionId,
        metodoPlanificacionId:
            metodoPlanificacionId ?? this.metodoPlanificacionId,
        conductaSeguirId: conductaSeguirId ?? this.conductaSeguirId,
        lstServiciosSolicitados:
            lstServiciosSolicitados ?? this.lstServiciosSolicitados,
        lstNombresEnfermedades:
            lstNombresEnfermedades ?? this.lstNombresEnfermedades,
        formStatus: formStatus ?? this.formStatus,
      );

  @override
  List<Object?> get props => [
        cuidadoSaludCondRiesgoId,
        afiliadoId,
        familiaId,
        ultimaVezInstSaludId,
        seguimientoEnfermedadId,
        condicionNutricionalId,
        tosFlemaId,
        manchasPielId,
        carnetVacunacionId,
        esquemaVacunacionId,
        lugarVacunacionId,
        utilizaMetodoPlanificacionId,
        metodoPlanificacionId,
        conductaSeguirId,
        lstServiciosSolicitados,
        lstNombresEnfermedades,
        formStatus,
      ];
}
