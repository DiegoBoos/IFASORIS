part of 'servicio_solicitado_cubit.dart';

abstract class ServiciosSolicitadosState extends Equatable {
  final List<ServicioSolicitadoEntity>? serviciosSolicitados;

  const ServiciosSolicitadosState({this.serviciosSolicitados});

  @override
  List<Object> get props => [];
}

class ServiciosSolicitadosInitial extends ServiciosSolicitadosState {}

class ServiciosSolicitadosLoading extends ServiciosSolicitadosState {}

class ServiciosSolicitadosLoaded extends ServiciosSolicitadosState {
  final List<ServicioSolicitadoEntity>? serviciosSolicitadosLoaded;

  const ServiciosSolicitadosLoaded(this.serviciosSolicitadosLoaded)
      : super(serviciosSolicitados: serviciosSolicitadosLoaded);
}

class ServiciosSolicitadosError extends ServiciosSolicitadosState {
  final String message;

  const ServiciosSolicitadosError(this.message);
}
