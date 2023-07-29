part of 'lugar_vacunacion_cubit.dart';

abstract class LugaresVacunacionState extends Equatable {
  final List<LugarVacunacionEntity>? lugaresVacunacion;

  const LugaresVacunacionState({this.lugaresVacunacion});

  @override
  List<Object> get props => [];
}

class LugaresVacunacionInitial extends LugaresVacunacionState {}

class LugaresVacunacionLoading extends LugaresVacunacionState {}

class LugaresVacunacionLoaded extends LugaresVacunacionState {
  final List<LugarVacunacionEntity>? lugaresVacunacionLoaded;

  const LugaresVacunacionLoaded(this.lugaresVacunacionLoaded)
      : super(lugaresVacunacion: lugaresVacunacionLoaded);
}

class LugaresVacunacionError extends LugaresVacunacionState {
  final String message;

  const LugaresVacunacionError(this.message);
}
