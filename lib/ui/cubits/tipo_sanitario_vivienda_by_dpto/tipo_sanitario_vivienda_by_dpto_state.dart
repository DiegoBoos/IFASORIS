part of 'tipo_sanitario_vivienda_by_dpto_cubit.dart';

abstract class TiposSanitarioViviendaByDptoState extends Equatable {
  final List<TipoSanitarioViviendaEntity>? tiposSanitarioViviendaByDpto;
  const TiposSanitarioViviendaByDptoState({this.tiposSanitarioViviendaByDpto});

  @override
  List<Object> get props => [];
}

class TiposSanitarioViviendaByDptoInitial
    extends TiposSanitarioViviendaByDptoState {}

class TiposSanitarioViviendaByDptoLoading
    extends TiposSanitarioViviendaByDptoState {}

class TiposSanitarioViviendaByDptoLoaded
    extends TiposSanitarioViviendaByDptoState {
  final List<TipoSanitarioViviendaEntity>? tiposSanitarioViviendaByDptoLoaded;

  const TiposSanitarioViviendaByDptoLoaded(
      this.tiposSanitarioViviendaByDptoLoaded)
      : super(tiposSanitarioViviendaByDpto: tiposSanitarioViviendaByDptoLoaded);
}

class TiposSanitarioViviendaByDptoError
    extends TiposSanitarioViviendaByDptoState {
  final String message;

  const TiposSanitarioViviendaByDptoError(this.message);
}
