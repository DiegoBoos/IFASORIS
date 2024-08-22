part of 'nro_cuarto_vivienda_cubit.dart';

abstract class NroCuartosViviendaState extends Equatable {
  final List<NroCuartoViviendaEntity>? nroCuartosVivienda;
  const NroCuartosViviendaState({this.nroCuartosVivienda});

  @override
  List<Object> get props => [];
}

class NroCuartosViviendaInitial extends NroCuartosViviendaState {}

class NroCuartosViviendaLoading extends NroCuartosViviendaState {}

class NroCuartosViviendaLoaded extends NroCuartosViviendaState {
  final List<NroCuartoViviendaEntity>? nroCuartosViviendaLoaded;

  const NroCuartosViviendaLoaded(this.nroCuartosViviendaLoaded)
      : super(nroCuartosVivienda: nroCuartosViviendaLoaded);
}

class NroCuartosViviendaError extends NroCuartosViviendaState {
  final String message;

  const NroCuartosViviendaError(this.message);
}
