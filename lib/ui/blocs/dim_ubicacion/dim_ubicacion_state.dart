part of 'dim_ubicacion_bloc.dart';

abstract class DimUbicacionState {
  const DimUbicacionState();
}

class FormInitial extends DimUbicacionState {
  const FormInitial();
}

class FormLoaded extends DimUbicacionState {}

class FormEmpty extends DimUbicacionState {}

class SubmissionSuccess extends DimUbicacionState {}

class SubmissionFailed extends DimUbicacionState {
  final String message;

  SubmissionFailed(this.message);
}

DimUbicacionEntity initObject() {
  return DimUbicacionEntity(
      ubicacionId: 0,
      familiaId: 0,
      nombreRecibeVisita: '',
      tipoDocRecibeVisita: '',
      documentoRecibeVisita: '',
      nombreMedTradicional: '',
      costoDesplazamientoMedTradicional: 0,
      resguardoId: 0,
      autoridadIndigenaId: 0,
      tuberculoPlatanoId: 0,
      poseeChagra: 0,
      leguminosaId: 0,
      hortalizaId: 0,
      verduraId: 0,
      frutoId: 0,
      cerealId: 0,
      especieAnimalCriaId: 0,
      produccionMinera: 0,
      tipoCalendarioId: 0);
}
