part of 'tipo_sanitario_vivienda_cubit.dart';

abstract class TiposSanitarioViviendaState extends Equatable {
  final List<TipoSanitarioViviendaEntity>? tiposSanitarioVivienda;
  const TiposSanitarioViviendaState({this.tiposSanitarioVivienda});

  @override
  List<Object> get props => [];
}

class TiposSanitarioViviendaInitial extends TiposSanitarioViviendaState {}

class TiposSanitarioViviendaLoading extends TiposSanitarioViviendaState {}

class TiposSanitarioViviendaLoaded extends TiposSanitarioViviendaState {
  final List<TipoSanitarioViviendaEntity>? tiposSanitarioViviendaLoaded;

  const TiposSanitarioViviendaLoaded(this.tiposSanitarioViviendaLoaded)
      : super(tiposSanitarioVivienda: tiposSanitarioViviendaLoaded);
}

class TiposSanitarioViviendaError extends TiposSanitarioViviendaState {
  final String message;

  const TiposSanitarioViviendaError(this.message);
}
