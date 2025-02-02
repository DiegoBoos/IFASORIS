part of 'tiempo_tarda_med_tradicional_cubit.dart';

abstract class TiemposTardaMedTradicionalState extends Equatable {
  final List<TiempoTardaMedTradicionalEntity>? tiemposTardaMedTradicional;
  const TiemposTardaMedTradicionalState({this.tiemposTardaMedTradicional});

  @override
  List<Object> get props => [];
}

class TiemposTardaMedTradicionalInitial
    extends TiemposTardaMedTradicionalState {}

class TiemposTardaMedTradicionalLoading
    extends TiemposTardaMedTradicionalState {}

class TiemposTardaMedTradicionalLoaded extends TiemposTardaMedTradicionalState {
  final List<TiempoTardaMedTradicionalEntity>? tiemposTardaMedTradicionalLoaded;

  const TiemposTardaMedTradicionalLoaded(this.tiemposTardaMedTradicionalLoaded)
      : super(tiemposTardaMedTradicional: tiemposTardaMedTradicionalLoaded);
}

class TiemposTardaMedTradicionalError extends TiemposTardaMedTradicionalState {
  final String message;

  const TiemposTardaMedTradicionalError(this.message);
}
