part of 'nombre_enfermedad_cubit.dart';

abstract class NombresEnfermedadesState extends Equatable {
  final List<NombreEnfermedadEntity>? nombresEnfermedades;

  const NombresEnfermedadesState({this.nombresEnfermedades});

  @override
  List<Object> get props => [];
}

class NombresEnfermedadesInitial extends NombresEnfermedadesState {}

class NombresEnfermedadesLoading extends NombresEnfermedadesState {}

class NombresEnfermedadesLoaded extends NombresEnfermedadesState {
  final List<NombreEnfermedadEntity>? nombresEnfermedadesLoaded;

  const NombresEnfermedadesLoaded(this.nombresEnfermedadesLoaded)
      : super(nombresEnfermedades: nombresEnfermedadesLoaded);
}

class NombresEnfermedadesError extends NombresEnfermedadesState {
  final String message;

  const NombresEnfermedadesError(this.message);
}
