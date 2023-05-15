part of 'tenencia_vivienda_by_dpto_cubit.dart';

abstract class TenenciasViviendaByDptoState extends Equatable {
  final List<TenenciaViviendaEntity>? tenenciasViviendaByDpto;
  const TenenciasViviendaByDptoState({this.tenenciasViviendaByDpto});

  @override
  List<Object> get props => [];
}

class TenenciasViviendaByDptoInitial extends TenenciasViviendaByDptoState {}

class TenenciasViviendaByDptoLoading extends TenenciasViviendaByDptoState {}

class TenenciasViviendaByDptoLoaded extends TenenciasViviendaByDptoState {
  final List<TenenciaViviendaEntity>? tenenciasViviendaByDptoLoaded;

  const TenenciasViviendaByDptoLoaded(this.tenenciasViviendaByDptoLoaded)
      : super(tenenciasViviendaByDpto: tenenciasViviendaByDptoLoaded);
}

class TenenciasViviendaByDptoError extends TenenciasViviendaByDptoState {
  final String message;

  const TenenciasViviendaByDptoError(this.message);
}
