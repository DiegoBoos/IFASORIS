part of 'cuarto_vivienda_cubit.dart';

abstract class CuartosViviendaState extends Equatable {
  final List<CuartoViviendaEntity>? cuartosVivienda;
  const CuartosViviendaState({this.cuartosVivienda});

  @override
  List<Object> get props => [];
}

class CuartosViviendaInitial extends CuartosViviendaState {}

class CuartosViviendaLoading extends CuartosViviendaState {}

class CuartosViviendaLoaded extends CuartosViviendaState {
  final List<CuartoViviendaEntity>? cuartosViviendaLoaded;

  const CuartosViviendaLoaded(this.cuartosViviendaLoaded)
      : super(cuartosVivienda: cuartosViviendaLoaded);
}

class CuartosViviendaError extends CuartosViviendaState {
  final String message;

  const CuartosViviendaError(this.message);
}
