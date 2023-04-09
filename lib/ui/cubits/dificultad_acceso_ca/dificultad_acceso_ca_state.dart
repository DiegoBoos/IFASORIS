part of 'dificultad_acceso_ca_cubit.dart';

abstract class DificultadesAccesoCAState extends Equatable {
  final List<DificultadAccesoCAEntity>? dificultadesAccesoCA;
  const DificultadesAccesoCAState({this.dificultadesAccesoCA});

  @override
  List<Object> get props => [];
}

class DificultadesAccesoCAInitial extends DificultadesAccesoCAState {}

class DificultadesAccesoCALoading extends DificultadesAccesoCAState {}

class DificultadesAccesoCALoaded extends DificultadesAccesoCAState {
  final List<DificultadAccesoCAEntity>? dificultadesAccesoCALoaded;

  const DificultadesAccesoCALoaded(this.dificultadesAccesoCALoaded)
      : super(dificultadesAccesoCA: dificultadesAccesoCALoaded);
}

class DificultadesAccesoCAError extends DificultadesAccesoCAState {
  final String message;

  const DificultadesAccesoCAError(this.message);
}
