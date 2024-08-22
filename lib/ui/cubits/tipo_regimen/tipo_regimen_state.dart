part of 'tipo_regimen_cubit.dart';

abstract class TipoRegimenesState extends Equatable {
  final List<TipoRegimenEntity>? tiporegimenes;
  const TipoRegimenesState({this.tiporegimenes});

  @override
  List<Object> get props => [];
}

class TipoRegimenesInitial extends TipoRegimenesState {}

class TipoRegimenesLoading extends TipoRegimenesState {}

class TipoRegimenesLoaded extends TipoRegimenesState {
  final List<TipoRegimenEntity>? tiporegimenesLoaded;

  const TipoRegimenesLoaded(this.tiporegimenesLoaded)
      : super(tiporegimenes: tiporegimenesLoaded);
}

class TipoRegimenesError extends TipoRegimenesState {
  final String message;

  const TipoRegimenesError(this.message);
}
