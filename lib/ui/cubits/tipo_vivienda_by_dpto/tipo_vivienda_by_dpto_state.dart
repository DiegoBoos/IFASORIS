part of 'tipo_vivienda_by_dpto_cubit.dart';

abstract class TiposViviendaByDptoState extends Equatable {
  final List<TipoViviendaEntity>? tiposViviendaByDpto;
  const TiposViviendaByDptoState({this.tiposViviendaByDpto});

  @override
  List<Object> get props => [];
}

class TiposViviendaByDptoInitial extends TiposViviendaByDptoState {}

class TiposViviendaByDptoLoading extends TiposViviendaByDptoState {}

class TiposViviendaByDptoLoaded extends TiposViviendaByDptoState {
  final List<TipoViviendaEntity>? tiposViviendaByDptoLoaded;

  const TiposViviendaByDptoLoaded(this.tiposViviendaByDptoLoaded)
      : super(tiposViviendaByDpto: tiposViviendaByDptoLoaded);
}

class TiposViviendaByDptoError extends TiposViviendaByDptoState {
  final String message;

  const TiposViviendaByDptoError(this.message);
}
