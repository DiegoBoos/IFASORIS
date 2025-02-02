part of 'medio_comunicacion_cubit.dart';

abstract class MediosComunicacionState extends Equatable {
  final List<MedioComunicacionEntity>? mediosComunicacion;
  const MediosComunicacionState({this.mediosComunicacion});

  @override
  List<Object> get props => [];
}

class MedioComunicacionInitial extends MediosComunicacionState {}

class MediosComunicacionInitial extends MediosComunicacionState {}

class MediosComunicacionLoading extends MediosComunicacionState {}

class MediosComunicacionLoaded extends MediosComunicacionState {
  final List<MedioComunicacionEntity>? mediosComunicacionLoaded;

  const MediosComunicacionLoaded(this.mediosComunicacionLoaded)
      : super(mediosComunicacion: mediosComunicacionLoaded);
}

class MediosComunicacionError extends MediosComunicacionState {
  final String message;

  const MediosComunicacionError(this.message);
}
