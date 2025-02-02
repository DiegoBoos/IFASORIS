part of 'dificultad_acceso_med_tradicional_cubit.dart';

abstract class DificultadesAccesoMedTradicionalState extends Equatable {
  final List<DificultadAccesoMedTradicionalEntity>?
      dificultadesAccesoMedTradicional;
  const DificultadesAccesoMedTradicionalState(
      {this.dificultadesAccesoMedTradicional});

  @override
  List<Object> get props => [];
}

class DificultadesAccesoMedTradicionalInitial
    extends DificultadesAccesoMedTradicionalState {}

class DificultadesAccesoMedTradicionalLoading
    extends DificultadesAccesoMedTradicionalState {}

class DificultadesAccesoMedTradicionalLoaded
    extends DificultadesAccesoMedTradicionalState {
  final List<DificultadAccesoMedTradicionalEntity>?
      dificultadesAccesoMedTradicionalLoaded;

  const DificultadesAccesoMedTradicionalLoaded(
      this.dificultadesAccesoMedTradicionalLoaded)
      : super(
            dificultadesAccesoMedTradicional:
                dificultadesAccesoMedTradicionalLoaded);
}

class DificultadesAccesoMedTradicionalError
    extends DificultadesAccesoMedTradicionalState {
  final String message;

  const DificultadesAccesoMedTradicionalError(this.message);
}
