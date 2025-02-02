part of 'cuidado_salud_cond_riesgo_bloc.dart';

abstract class CuidadoSaludCondRiesgoState {
  const CuidadoSaludCondRiesgoState();
}

class CuidadoSaludCondRiesgoFormInitial extends CuidadoSaludCondRiesgoState {
  const CuidadoSaludCondRiesgoFormInitial();
}

class CuidadoSaludCondRiesgoFormLoading extends CuidadoSaludCondRiesgoState {}

class CuidadoSaludCondRiesgoFormEmpty extends CuidadoSaludCondRiesgoState {}

class CuidadoSaludCondRiesgoFormLoaded extends CuidadoSaludCondRiesgoState {}

class CuidadoSaludCondRiesgoSubmissionSuccess
    extends CuidadoSaludCondRiesgoState {}

class CuidadoSaludCondRiesgoSubmissionFailed
    extends CuidadoSaludCondRiesgoState {
  final String message;

  CuidadoSaludCondRiesgoSubmissionFailed(this.message);
}

CuidadoSaludCondRiesgoEntity initObject() {
  return const CuidadoSaludCondRiesgoEntity(
      formStatus: CuidadoSaludCondRiesgoFormInitial());
}
