part of 'tiempo_tarda_ca_cubit.dart';

abstract class TiemposTardaCAState extends Equatable {
  final List<TiempoTardaCAEntity>? tiemposTardaCA;
  const TiemposTardaCAState({this.tiemposTardaCA});

  @override
  List<Object> get props => [];
}

class TiemposTardaCAInitial extends TiemposTardaCAState {}

class TiemposTardaCALoading extends TiemposTardaCAState {}

class TiemposTardaCALoaded extends TiemposTardaCAState {
  final List<TiempoTardaCAEntity>? tiemposTardaCALoaded;

  const TiemposTardaCALoaded(this.tiemposTardaCALoaded)
      : super(tiemposTardaCA: tiemposTardaCALoaded);
}

class TiemposTardaCAError extends TiemposTardaCAState {
  final String message;

  const TiemposTardaCAError(this.message);
}
