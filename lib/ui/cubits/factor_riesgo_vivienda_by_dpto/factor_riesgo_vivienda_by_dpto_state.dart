part of 'factor_riesgo_vivienda_by_dpto_cubit.dart';

abstract class FactoresRiesgoViviendaByDptoState extends Equatable {
  final List<FactorRiesgoViviendaEntity>? factoresRiesgoViviendaByDpto;
  const FactoresRiesgoViviendaByDptoState({this.factoresRiesgoViviendaByDpto});

  @override
  List<Object> get props => [];
}

class FactoresRiesgoViviendaByDptoInitial
    extends FactoresRiesgoViviendaByDptoState {}

class FactoresRiesgoViviendaByDptoLoading
    extends FactoresRiesgoViviendaByDptoState {}

class FactoresRiesgoViviendaByDptoLoaded
    extends FactoresRiesgoViviendaByDptoState {
  final List<FactorRiesgoViviendaEntity>? factoresRiesgoViviendaByDptoLoaded;

  const FactoresRiesgoViviendaByDptoLoaded(
      this.factoresRiesgoViviendaByDptoLoaded)
      : super(factoresRiesgoViviendaByDpto: factoresRiesgoViviendaByDptoLoaded);
}

class FactoresRiesgoViviendaByDptoError
    extends FactoresRiesgoViviendaByDptoState {
  final String message;

  const FactoresRiesgoViviendaByDptoError(this.message);
}
