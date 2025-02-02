part of 'seguimiento_enfermedad_cubit.dart';

abstract class SeguimientoEnfermedadesState extends Equatable {
  final List<SeguimientoEnfermedadEntity>? seguimientoEnfermedades;

  const SeguimientoEnfermedadesState({this.seguimientoEnfermedades});

  @override
  List<Object> get props => [];
}

class SeguimientoEnfermedadesInitial extends SeguimientoEnfermedadesState {}

class SeguimientoEnfermedadesLoading extends SeguimientoEnfermedadesState {}

class SeguimientoEnfermedadesLoaded extends SeguimientoEnfermedadesState {
  final List<SeguimientoEnfermedadEntity>? seguimientoEnfermedadesLoaded;

  const SeguimientoEnfermedadesLoaded(this.seguimientoEnfermedadesLoaded)
      : super(seguimientoEnfermedades: seguimientoEnfermedadesLoaded);
}

class SeguimientoEnfermedadesError extends SeguimientoEnfermedadesState {
  final String message;

  const SeguimientoEnfermedadesError(this.message);
}
