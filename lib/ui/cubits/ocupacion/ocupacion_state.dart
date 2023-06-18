part of 'ocupacion_cubit.dart';

abstract class OcupacionesState extends Equatable {
  final List<OcupacionEntity>? ocupaciones;
  const OcupacionesState({this.ocupaciones});

  @override
  List<Object> get props => [];
}

class OcupacionesInitial extends OcupacionesState {}

class OcupacionesLoading extends OcupacionesState {}

class OcupacionesLoaded extends OcupacionesState {
  final List<OcupacionEntity>? ocupacionesLoaded;

  const OcupacionesLoaded(this.ocupacionesLoaded)
      : super(ocupaciones: ocupacionesLoaded);
}

class OcupacionesError extends OcupacionesState {
  final String message;

  const OcupacionesError(this.message);
}
