part of 'cuidado_salud_cond_riesgo_bloc.dart';

abstract class CuidadoSaludCondRiesgoEvent extends Equatable {
  const CuidadoSaludCondRiesgoEvent();

  @override
  List<Object> get props => [];
}

class CuidadoSaludCondRiesgoInit extends CuidadoSaludCondRiesgoEvent {}

class CuidadoSaludCondRiesgoSubmitted extends CuidadoSaludCondRiesgoEvent {
  final CuidadoSaludCondRiesgoEntity cuidadoSaludCondRiesgo;

  const CuidadoSaludCondRiesgoSubmitted(this.cuidadoSaludCondRiesgo);
}

class GetCuidadoSaludCondRiesgo extends CuidadoSaludCondRiesgoEvent {
  final int afiliadoId;

  const GetCuidadoSaludCondRiesgo(this.afiliadoId);
}

class CuidadoSaludCondRiesgoFormSubmissionSuccess
    extends CuidadoSaludCondRiesgoEvent {
  final int ubicacionId;

  const CuidadoSaludCondRiesgoFormSubmissionSuccess(this.ubicacionId);
}

class CuidadoSaludCondRiesgoFormSubmissionFailed
    extends CuidadoSaludCondRiesgoEvent {
  final String message;

  const CuidadoSaludCondRiesgoFormSubmissionFailed(this.message);
}

class CuidadoSaludCondRiesgoChanged extends CuidadoSaludCondRiesgoEvent {
  final int cuidadoSaludCondRiesgoId;

  const CuidadoSaludCondRiesgoChanged(this.cuidadoSaludCondRiesgoId);
}

class AfiliadoChanged extends CuidadoSaludCondRiesgoEvent {
  final int afiliadoId;

  const AfiliadoChanged(this.afiliadoId);
}

class FamiliaChanged extends CuidadoSaludCondRiesgoEvent {
  final int familiaId;

  const FamiliaChanged(this.familiaId);
}

class UltimaVezInstSaludChanged extends CuidadoSaludCondRiesgoEvent {
  final int ultimaVezInstSaludId;

  const UltimaVezInstSaludChanged(this.ultimaVezInstSaludId);
}

class SeguimientoEnfermedadChanged extends CuidadoSaludCondRiesgoEvent {
  final int seguimientoEnfermedadId;

  const SeguimientoEnfermedadChanged(this.seguimientoEnfermedadId);
}

class CondicionNutricionalChanged extends CuidadoSaludCondRiesgoEvent {
  final int condicionNutricionalId;

  const CondicionNutricionalChanged(this.condicionNutricionalId);
}

class TosFlemaChanged extends CuidadoSaludCondRiesgoEvent {
  final int tosFlemaId;

  const TosFlemaChanged(this.tosFlemaId);
}

class ManchasPielChanged extends CuidadoSaludCondRiesgoEvent {
  final int manchasPielId;

  const ManchasPielChanged(this.manchasPielId);
}

class CarnetVacunacionChanged extends CuidadoSaludCondRiesgoEvent {
  final int carnetVacunacionId;

  const CarnetVacunacionChanged(this.carnetVacunacionId);
}

class EsquemaVacunacionChanged extends CuidadoSaludCondRiesgoEvent {
  final int esquemaVacunacionId;

  const EsquemaVacunacionChanged(this.esquemaVacunacionId);
}

class LugarVacunacionChanged extends CuidadoSaludCondRiesgoEvent {
  final int lugarVacunacionId;

  const LugarVacunacionChanged(this.lugarVacunacionId);
}

class UtilizaMetodoPlanificacionChanged extends CuidadoSaludCondRiesgoEvent {
  final int utilizaMetodoPlanificacionId;

  const UtilizaMetodoPlanificacionChanged(this.utilizaMetodoPlanificacionId);
}

class MetodoPlanificacionChanged extends CuidadoSaludCondRiesgoEvent {
  final int metodoPlanificacionId;

  const MetodoPlanificacionChanged(this.metodoPlanificacionId);
}

class ConductaSeguirChanged extends CuidadoSaludCondRiesgoEvent {
  final int conductaSeguirId;

  const ConductaSeguirChanged(this.conductaSeguirId);
}

class NombresEnfermedadesChanged extends CuidadoSaludCondRiesgoEvent {
  final List<LstNombreEnfermedad> lstNombresEnfermedades;

  const NombresEnfermedadesChanged(this.lstNombresEnfermedades);
}

class ServiciosSolicitadosChanged extends CuidadoSaludCondRiesgoEvent {
  final List<LstServicioSolicitado> lstServiciosSolicitados;

  const ServiciosSolicitadosChanged(this.lstServiciosSolicitados);
}
