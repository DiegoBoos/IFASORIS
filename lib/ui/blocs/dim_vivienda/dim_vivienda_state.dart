part of 'dim_vivienda_bloc.dart';

abstract class DimViviendaState {
  const DimViviendaState();
}

class DimViviendaFormInitial extends DimViviendaState {
  const DimViviendaFormInitial();
}

class DimViviendaFormLoaded extends DimViviendaState {}

class DimViviendaFormEmpty extends DimViviendaState {}

class DimViviendaSubmissionSuccess extends DimViviendaState {}

class DimViviendaSubmissionFailed extends DimViviendaState {
  final String message;

  DimViviendaSubmissionFailed(this.message);
}

DimViviendaEntity initObject() {
  return DimViviendaEntity(formStatus: const DimViviendaFormInitial());
}
