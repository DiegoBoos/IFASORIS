part of 'lugar_atencion_medico_cubit.dart';

abstract class LugaresAtencionMedicoState extends Equatable {
  final List<LugarAtencionMedicoEntity>? lugaresAtencionMedico;

  const LugaresAtencionMedicoState({this.lugaresAtencionMedico});

  @override
  List<Object> get props => [];
}

class LugaresAtencionMedicoInitial extends LugaresAtencionMedicoState {}

class LugaresAtencionMedicoLoading extends LugaresAtencionMedicoState {}

class LugaresAtencionMedicoLoaded extends LugaresAtencionMedicoState {
  final List<LugarAtencionMedicoEntity>? lugaresAtencionMedicoLoaded;

  const LugaresAtencionMedicoLoaded(this.lugaresAtencionMedicoLoaded)
      : super(lugaresAtencionMedico: lugaresAtencionMedicoLoaded);
}

class LugaresAtencionMedicoError extends LugaresAtencionMedicoState {
  final String message;

  const LugaresAtencionMedicoError(this.message);
}
