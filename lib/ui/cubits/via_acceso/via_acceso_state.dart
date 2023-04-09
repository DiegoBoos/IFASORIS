part of 'via_acceso_cubit.dart';

abstract class ViasAccesoState extends Equatable {
  final List<ViaAccesoEntity>? viasAcceso;
  const ViasAccesoState({this.viasAcceso});

  @override
  List<Object> get props => [];
}

class ViasAccesoInitial extends ViasAccesoState {}

class ViasAccesoLoading extends ViasAccesoState {}

class ViasAccesoLoaded extends ViasAccesoState {
  final List<ViaAccesoEntity>? viasAccesoLoaded;

  const ViasAccesoLoaded(this.viasAccesoLoaded)
      : super(viasAcceso: viasAccesoLoaded);
}

class ViasAccesoError extends ViasAccesoState {
  final String message;

  const ViasAccesoError(this.message);
}
