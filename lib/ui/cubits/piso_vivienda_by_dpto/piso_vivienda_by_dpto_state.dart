part of 'piso_vivienda_by_dpto_cubit.dart';

abstract class PisosViviendaByDptoState extends Equatable {
  final List<PisoViviendaEntity>? pisosViviendaByDpto;
  const PisosViviendaByDptoState({this.pisosViviendaByDpto});

  @override
  List<Object> get props => [];
}

class PisosViviendaByDptoInitial extends PisosViviendaByDptoState {}

class PisosViviendaByDptoLoading extends PisosViviendaByDptoState {}

class PisosViviendaByDptoLoaded extends PisosViviendaByDptoState {
  final List<PisoViviendaEntity>? pisosViviendaByDptoLoaded;

  const PisosViviendaByDptoLoaded(this.pisosViviendaByDptoLoaded)
      : super(pisosViviendaByDpto: pisosViviendaByDptoLoaded);
}

class PisosViviendaByDptoError extends PisosViviendaByDptoState {
  final String message;

  const PisosViviendaByDptoError(this.message);
}
