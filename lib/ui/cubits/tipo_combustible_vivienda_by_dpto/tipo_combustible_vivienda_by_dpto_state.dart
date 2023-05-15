part of 'tipo_combustible_vivienda_by_dpto_cubit.dart';

abstract class TiposCombustibleViviendaByDptoState extends Equatable {
  final List<TipoCombustibleViviendaEntity>? tiposCombustibleViviendaByDpto;
  const TiposCombustibleViviendaByDptoState(
      {this.tiposCombustibleViviendaByDpto});

  @override
  List<Object> get props => [];
}

class TiposCombustibleViviendaByDptoInitial
    extends TiposCombustibleViviendaByDptoState {}

class TiposCombustibleViviendaByDptoLoading
    extends TiposCombustibleViviendaByDptoState {}

class TiposCombustibleViviendaByDptoLoaded
    extends TiposCombustibleViviendaByDptoState {
  final List<TipoCombustibleViviendaEntity>?
      tiposCombustibleViviendaByDptoLoaded;

  const TiposCombustibleViviendaByDptoLoaded(
      this.tiposCombustibleViviendaByDptoLoaded)
      : super(
            tiposCombustibleViviendaByDpto:
                tiposCombustibleViviendaByDptoLoaded);
}

class TiposCombustibleViviendaByDptoError
    extends TiposCombustibleViviendaByDptoState {
  final String message;

  const TiposCombustibleViviendaByDptoError(this.message);
}
