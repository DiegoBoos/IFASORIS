import '../../data/models/nombre_enfermedad_model.dart';
import '../../data/models/servicio_solicitado_model.dart';
import '../../ui/blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';

class CuidadoSaludCondRiesgoEntity {
  CuidadoSaludCondRiesgoEntity({
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

  int? cuidadoSaludCondRiesgoId;
  int? afiliadoId;
  int? familiaId;
  int? ultimaVezInstSaludId;
  int? seguimientoEnfermedadId;
  int? condicionNutricionalId;
  int? tosFlemaId;
  int? manchasPielId;
  int? carnetVacunacionId;
  int? esquemaVacunacionId;
  int? lugarVacunacionId;
  int? utilizaMetodoPlanificacionId;
  int? metodoPlanificacionId;
  int? conductaSeguirId;
  List<LstServicioSolicitado>? lstServiciosSolicitados;
  List<LstNombreEnfermedad>? lstNombresEnfermedades;
  CuidadoSaludCondRiesgoState formStatus;

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

  Map<String, dynamic> toJson() => {
        "CuidadoSaludCondRiesgo_id": cuidadoSaludCondRiesgoId,
        "Afiliado_id": afiliadoId,
        "Familia_id": familiaId,
        "UltimaVezInstSalud_id": ultimaVezInstSaludId,
        "SeguimientoEnfermedad_id": seguimientoEnfermedadId,
        "CondicionNutricional_id": condicionNutricionalId,
        "TosFlema_id": tosFlemaId,
        "ManchasPiel_id": manchasPielId,
        "CarnetVacunacion_id": carnetVacunacionId,
        "EsquemaVacunacion_id": esquemaVacunacionId,
        "LugarVacunacion_id": lugarVacunacionId,
        "UtilizaMetodoPlanificacion_id": utilizaMetodoPlanificacionId,
        "MetodoPlanificacion_id": metodoPlanificacionId,
        "ConductaSeguir_id": conductaSeguirId
      };
}
