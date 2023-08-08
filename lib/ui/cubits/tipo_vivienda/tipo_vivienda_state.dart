part of 'tipo_vivienda_cubit.dart';

abstract class TiposViviendaState extends Equatable {
  final List<TipoViviendaEntity>? tiposVivienda;
  const TiposViviendaState({this.tiposVivienda});

  @override
  List<Object> get props => [];
}

class TiposViviendaInitial extends TiposViviendaState {}

class TiposViviendaLoading extends TiposViviendaState {}

class TiposViviendaLoaded extends TiposViviendaState {
  final List<TipoViviendaEntity>? tiposViviendaLoaded;

  const TiposViviendaLoaded(this.tiposViviendaLoaded)
      : super(tiposVivienda: tiposViviendaLoaded);
}

class TiposViviendaError extends TiposViviendaState {
  final String message;

  const TiposViviendaError(this.message);
}
