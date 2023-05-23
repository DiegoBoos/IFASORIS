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
  //TODO: Revisar init object
  return DimUbicacionEntity(
    ubicacionId: 0,
    familiaId: 0,
    nombreRecibeVisita: '',
    tipoDocRecibeVisita: '',
    documentoRecibeVisita: '',
    resguardoId: 0,
    produccionMinera: 0,
  );
}
