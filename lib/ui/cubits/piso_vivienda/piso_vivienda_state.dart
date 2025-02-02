part of 'piso_vivienda_cubit.dart';

abstract class PisosViviendaState extends Equatable {
  final List<PisoViviendaEntity>? pisosVivienda;
  const PisosViviendaState({this.pisosVivienda});

  @override
  List<Object> get props => [];
}

class PisosViviendaInitial extends PisosViviendaState {}

class PisosViviendaLoading extends PisosViviendaState {}

class PisosViviendaLoaded extends PisosViviendaState {
  final List<PisoViviendaEntity>? pisosViviendaLoaded;

  const PisosViviendaLoaded(this.pisosViviendaLoaded)
      : super(pisosVivienda: pisosViviendaLoaded);
}

class PisosViviendaError extends PisosViviendaState {
  final String message;

  const PisosViviendaError(this.message);
}
