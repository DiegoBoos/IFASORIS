part of 'tipo_combustible_vivienda_cubit.dart';

abstract class TiposCombustibleViviendaState extends Equatable {
  final List<TipoCombustibleViviendaEntity>? tiposCombustibleVivienda;
  const TiposCombustibleViviendaState({this.tiposCombustibleVivienda});

  @override
  List<Object> get props => [];
}

class TiposCombustibleViviendaInitial extends TiposCombustibleViviendaState {}

class TiposCombustibleViviendaLoading extends TiposCombustibleViviendaState {}

class TiposCombustibleViviendaLoaded extends TiposCombustibleViviendaState {
  final List<TipoCombustibleViviendaEntity>? tiposCombustibleViviendaLoaded;

  const TiposCombustibleViviendaLoaded(this.tiposCombustibleViviendaLoaded)
      : super(tiposCombustibleVivienda: tiposCombustibleViviendaLoaded);
}

class TiposCombustibleViviendaError extends TiposCombustibleViviendaState {
  final String message;

  const TiposCombustibleViviendaError(this.message);
}
