part of 'atencion_salud_bloc.dart';

abstract class AtencionSaludState {
  const AtencionSaludState();
}

class AtencionSaludFormInitial extends AtencionSaludState {
  const AtencionSaludFormInitial();
}

class AtencionSaludFormLoaded extends AtencionSaludState {}

class AtencionSaludFormEmpty extends AtencionSaludState {}

class AtencionSaludSubmissionSuccess extends AtencionSaludState {}

class AtencionSaludSubmissionFailed extends AtencionSaludState {
  final String message;

  AtencionSaludSubmissionFailed(this.message);
}

AtencionSaludEntity initObject() {
  return AtencionSaludEntity(formStatus: const AtencionSaludFormInitial());
}
