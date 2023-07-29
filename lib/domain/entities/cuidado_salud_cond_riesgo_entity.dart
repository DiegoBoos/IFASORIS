import '../../data/models/nombre_enfermedad_model.dart';
import '../../data/models/servicio_solicitado_model.dart';
import '../../ui/blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';

class CuidadoSaludCondRiesgoEntity {
  CuidadoSaludCondRiesgoEntity(
      {this.cuidadoSaludCondRiesgoId,
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
      this.lstNombresEnfermedades,
      this.lstServiciosSolicitados,
      this.presentaTos,
      this.presentaManchas,
      this.formStatus = const CuidadoSaludCondRiesgoFormInitial(),
      this.remoteCuidadoSaludCondRiesgo});

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
  List<LstNombreEnfermedad>? lstNombresEnfermedades;
  List<LstServicioSolicitado>? lstServiciosSolicitados;
  int? presentaTos;
  int? presentaManchas;
  CuidadoSaludCondRiesgoState formStatus;
  int? remoteCuidadoSaludCondRiesgo;

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
    List<LstNombreEnfermedad>? lstNombresEnfermedades,
    List<LstServicioSolicitado>? lstServiciosSolicitados,
    int? presentaTos,
    int? presentaManchas,
    CuidadoSaludCondRiesgoState? formStatus,
  }) =>
      CuidadoSaludCondRiesgoEntity(
        cuidadoSaludCondRiesgoId:
            cuidadoSaludCondRiesgoId ?? cuidadoSaludCondRiesgoId,
        afiliadoId: afiliadoId ?? afiliadoId,
        familiaId: familiaId ?? familiaId,
        ultimaVezInstSaludId: ultimaVezInstSaludId ?? ultimaVezInstSaludId,
        seguimientoEnfermedadId:
            seguimientoEnfermedadId ?? seguimientoEnfermedadId,
        condicionNutricionalId:
            condicionNutricionalId ?? condicionNutricionalId,
        tosFlemaId: tosFlemaId ?? tosFlemaId,
        manchasPielId: manchasPielId ?? manchasPielId,
        carnetVacunacionId: carnetVacunacionId ?? carnetVacunacionId,
        esquemaVacunacionId: esquemaVacunacionId ?? esquemaVacunacionId,
        lugarVacunacionId: lugarVacunacionId ?? lugarVacunacionId,
        utilizaMetodoPlanificacionId:
            utilizaMetodoPlanificacionId ?? utilizaMetodoPlanificacionId,
        metodoPlanificacionId: metodoPlanificacionId ?? metodoPlanificacionId,
        conductaSeguirId: conductaSeguirId ?? conductaSeguirId,
        lstNombresEnfermedades:
            lstNombresEnfermedades ?? lstNombresEnfermedades,
        lstServiciosSolicitados:
            lstServiciosSolicitados ?? lstServiciosSolicitados,
        presentaTos: presentaTos ?? presentaTos,
        presentaManchas: presentaManchas ?? presentaManchas,
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
        "ConductaSeguir_id": conductaSeguirId,
        "remoteCuidadoSaludCondRiesgo_id": remoteCuidadoSaludCondRiesgo,
      };
}
