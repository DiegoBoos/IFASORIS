part of 'metodo_planificacion_cubit.dart';

abstract class MetodosPlanificacionState extends Equatable {
  final List<MetodoPlanificacionEntity>? metodosPlanificacion;

  const MetodosPlanificacionState({this.metodosPlanificacion});

  @override
  List<Object> get props => [];
}

class MetodosPlanificacionInitial extends MetodosPlanificacionState {}

class MetodosPlanificacionLoading extends MetodosPlanificacionState {}

class MetodosPlanificacionLoaded extends MetodosPlanificacionState {
  final List<MetodoPlanificacionEntity>? metodosPlanificacionLoaded;

  const MetodosPlanificacionLoaded(this.metodosPlanificacionLoaded)
      : super(metodosPlanificacion: metodosPlanificacionLoaded);
}

class MetodosPlanificacionError extends MetodosPlanificacionState {
  final String message;

  const MetodosPlanificacionError(this.message);
}
