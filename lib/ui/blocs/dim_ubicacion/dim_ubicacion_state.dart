part of 'dim_ubicacion_bloc.dart';

abstract class DimUbicacionState {
  const DimUbicacionState();
}

class DimUbicacionFormInitial extends DimUbicacionState {
  const DimUbicacionFormInitial();
}

class DimUbicacionFormLoaded extends DimUbicacionState {}

class DimUbicacionFormEmpty extends DimUbicacionState {}

class DimUbicacionSubmissionSuccess extends DimUbicacionState {}

class DimUbicacionSubmissionFailed extends DimUbicacionState {
  final String message;

  DimUbicacionSubmissionFailed(this.message);
}

DimUbicacionEntity initObject() {
  return DimUbicacionEntity(
      tipoDocRecibeVisita: '',
      documentoRecibeVisita: '',
      resguardoId: 0,
      produccionMinera: 0,
      formStatus: const DimUbicacionFormInitial());
}
