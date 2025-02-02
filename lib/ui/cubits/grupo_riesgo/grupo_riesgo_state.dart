part of 'grupo_riesgo_cubit.dart';

abstract class GruposRiesgoState extends Equatable {
  final List<GrupoRiesgoEntity>? gruposRiesgo;
  const GruposRiesgoState({this.gruposRiesgo});

  @override
  List<Object> get props => [];
}

class GruposRiesgoInitial extends GruposRiesgoState {}

class GruposRiesgoLoading extends GruposRiesgoState {}

class GruposRiesgoLoaded extends GruposRiesgoState {
  final List<GrupoRiesgoEntity>? gruposRiesgoLoaded;

  const GruposRiesgoLoaded(this.gruposRiesgoLoaded)
      : super(gruposRiesgo: gruposRiesgoLoaded);
}

class GruposRiesgoError extends GruposRiesgoState {
  final String message;

  const GruposRiesgoError(this.message);
}
