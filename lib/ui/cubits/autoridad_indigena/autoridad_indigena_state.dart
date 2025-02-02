part of 'autoridad_indigena_cubit.dart';

abstract class AutoridadesIndigenasState extends Equatable {
  final List<AutoridadIndigenaEntity>? autoridadesIndigenas;
  const AutoridadesIndigenasState({this.autoridadesIndigenas});

  @override
  List<Object> get props => [];
}

class AutoridadesIndigenasInitial extends AutoridadesIndigenasState {}

class AutoridadesIndigenasLoading extends AutoridadesIndigenasState {}

class AutoridadesIndigenasLoaded extends AutoridadesIndigenasState {
  final List<AutoridadIndigenaEntity>? autoridadesIndigenasLoaded;

  const AutoridadesIndigenasLoaded(this.autoridadesIndigenasLoaded)
      : super(autoridadesIndigenas: autoridadesIndigenasLoaded);
}

class AutoridadesIndigenasError extends AutoridadesIndigenasState {
  final String message;

  const AutoridadesIndigenasError(this.message);
}
