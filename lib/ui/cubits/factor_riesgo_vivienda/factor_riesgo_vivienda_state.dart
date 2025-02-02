part of 'factor_riesgo_vivienda_cubit.dart';

abstract class FactoresRiesgoViviendaState extends Equatable {
  final List<FactorRiesgoViviendaEntity>? factoresRiesgoVivienda;
  const FactoresRiesgoViviendaState({this.factoresRiesgoVivienda});

  @override
  List<Object> get props => [];
}

class FactoresRiesgoViviendaInitial extends FactoresRiesgoViviendaState {}

class FactoresRiesgoViviendaLoading extends FactoresRiesgoViviendaState {}

class FactoresRiesgoViviendaLoaded extends FactoresRiesgoViviendaState {
  final List<FactorRiesgoViviendaEntity>? factoresRiesgoViviendaLoaded;

  const FactoresRiesgoViviendaLoaded(this.factoresRiesgoViviendaLoaded)
      : super(factoresRiesgoVivienda: factoresRiesgoViviendaLoaded);
}

class FactoresRiesgoViviendaError extends FactoresRiesgoViviendaState {
  final String message;

  const FactoresRiesgoViviendaError(this.message);
}
