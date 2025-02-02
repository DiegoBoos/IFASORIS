part of 'tenencia_vivienda_cubit.dart';

abstract class TenenciasViviendaState extends Equatable {
  final List<TenenciaViviendaEntity>? tenenciasVivienda;
  const TenenciasViviendaState({this.tenenciasVivienda});

  @override
  List<Object> get props => [];
}

class TenenciasViviendaInitial extends TenenciasViviendaState {}

class TenenciasViviendaLoading extends TenenciasViviendaState {}

class TenenciasViviendaLoaded extends TenenciasViviendaState {
  final List<TenenciaViviendaEntity>? tenenciasViviendaLoaded;

  const TenenciasViviendaLoaded(this.tenenciasViviendaLoaded)
      : super(tenenciasVivienda: tenenciasViviendaLoaded);
}

class TenenciasViviendaError extends TenenciasViviendaState {
  final String message;

  const TenenciasViviendaError(this.message);
}
