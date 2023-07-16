part of 'actividad_fisica_cubit.dart';

abstract class ActividadesFisicasState extends Equatable {
  final List<ActividadFisicaEntity>? actividadesFisicas;

  const ActividadesFisicasState({this.actividadesFisicas});

  @override
  List<Object> get props => [];
}

class ActividadesFisicasInitial extends ActividadesFisicasState {}

class ActividadesFisicasLoading extends ActividadesFisicasState {}

class ActividadesFisicasLoaded extends ActividadesFisicasState {
  final List<ActividadFisicaEntity>? actividadesFisicasLoaded;

  const ActividadesFisicasLoaded(this.actividadesFisicasLoaded)
      : super(actividadesFisicas: actividadesFisicasLoaded);
}

class ActividadesFisicasError extends ActividadesFisicasState {
  final String message;

  const ActividadesFisicasError(this.message);
}
