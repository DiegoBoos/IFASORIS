part of 'dificultad_acceso_med_tradicional_by_dpto_cubit.dart';

abstract class DificultadesAccesoMedTradicionalByDptoState extends Equatable {
  final List<DificultadAccesoMedTradicionalEntity>?
      dificultadesAccesoMedTradicionalByDpto;
  const DificultadesAccesoMedTradicionalByDptoState(
      {this.dificultadesAccesoMedTradicionalByDpto});

  @override
  List<Object> get props => [];
}

class DificultadesAccesoMedTradicionalByDptoInitial
    extends DificultadesAccesoMedTradicionalByDptoState {}

class DificultadesAccesoMedTradicionalByDptoLoading
    extends DificultadesAccesoMedTradicionalByDptoState {}

class DificultadesAccesoMedTradicionalByDptoLoaded
    extends DificultadesAccesoMedTradicionalByDptoState {
  final List<DificultadAccesoMedTradicionalEntity>?
      dificultadesAccesoMedTradicionalByDptoLoaded;

  const DificultadesAccesoMedTradicionalByDptoLoaded(
      this.dificultadesAccesoMedTradicionalByDptoLoaded)
      : super(
            dificultadesAccesoMedTradicionalByDpto:
                dificultadesAccesoMedTradicionalByDptoLoaded);
}

class DificultadesAccesoMedTradicionalByDptoError
    extends DificultadesAccesoMedTradicionalByDptoState {
  final String message;

  const DificultadesAccesoMedTradicionalByDptoError(this.message);
}
