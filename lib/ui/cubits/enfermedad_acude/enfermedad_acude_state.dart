part of 'enfermedad_acude_cubit.dart';

abstract class EnfermedadesAcudeState extends Equatable {
  final List<EnfermedadAcudeEntity>? enfermedadesAcude;

  const EnfermedadesAcudeState({this.enfermedadesAcude});

  @override
  List<Object> get props => [];
}

class EnfermedadesAcudeInitial extends EnfermedadesAcudeState {}

class EnfermedadesAcudeLoading extends EnfermedadesAcudeState {}

class EnfermedadesAcudeLoaded extends EnfermedadesAcudeState {
  final List<EnfermedadAcudeEntity>? enfermedadesAcudeLoaded;

  const EnfermedadesAcudeLoaded(this.enfermedadesAcudeLoaded)
      : super(enfermedadesAcude: enfermedadesAcudeLoaded);
}

class EnfermedadesAcudeError extends EnfermedadesAcudeState {
  final String message;

  const EnfermedadesAcudeError(this.message);
}
