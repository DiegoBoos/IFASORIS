part of 'alimentacion_cubit.dart';

abstract class AlimentacionesState extends Equatable {
  final List<AlimentacionEntity>? alimentaciones;
  const AlimentacionesState({this.alimentaciones});

  @override
  List<Object> get props => [];
}

class AlimentacionesInitial extends AlimentacionesState {}

class AlimentacionesLoading extends AlimentacionesState {}

class AlimentacionesLoaded extends AlimentacionesState {
  final List<AlimentacionEntity>? alimentacionesLoaded;

  const AlimentacionesLoaded(this.alimentacionesLoaded)
      : super(alimentaciones: alimentacionesLoaded);
}

class AlimentacionesError extends AlimentacionesState {
  final String message;

  const AlimentacionesError(this.message);
}
