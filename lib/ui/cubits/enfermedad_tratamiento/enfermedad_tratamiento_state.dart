part of 'enfermedad_tratamiento_cubit.dart';

abstract class EnfermedadesTratamientoState extends Equatable {
  final List<EnfermedadTratamientoEntity>? enfermedadesTratamiento;

  const EnfermedadesTratamientoState({this.enfermedadesTratamiento});

  @override
  List<Object> get props => [];
}

class EnfermedadesTratamientoInitial extends EnfermedadesTratamientoState {}

class EnfermedadesTratamientoLoading extends EnfermedadesTratamientoState {}

class EnfermedadesTratamientoLoaded extends EnfermedadesTratamientoState {
  final List<EnfermedadTratamientoEntity>? enfermedadesTratamientoLoaded;

  const EnfermedadesTratamientoLoaded(this.enfermedadesTratamientoLoaded)
      : super(enfermedadesTratamiento: enfermedadesTratamientoLoaded);
}

class EnfermedadesTratamientoError extends EnfermedadesTratamientoState {
  final String message;

  const EnfermedadesTratamientoError(this.message);
}
