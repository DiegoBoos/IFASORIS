part of 'estado_via_cubit.dart';

abstract class EstadosViasState extends Equatable {
  final List<EstadoViaEntity>? estadosVias;
  const EstadosViasState({this.estadosVias});

  @override
  List<Object> get props => [];
}

class EstadosViasInitial extends EstadosViasState {}

class EstadosViasLoading extends EstadosViasState {}

class EstadosViasLoaded extends EstadosViasState {
  final List<EstadoViaEntity>? estadosViasLoaded;

  const EstadosViasLoaded(this.estadosViasLoaded)
      : super(estadosVias: estadosViasLoaded);
}

class EstadosViasError extends EstadosViasState {
  final String message;

  const EstadosViasError(this.message);
}
