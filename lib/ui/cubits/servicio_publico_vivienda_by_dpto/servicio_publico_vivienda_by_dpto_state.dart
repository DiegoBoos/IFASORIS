part of 'servicio_publico_vivienda_by_dpto_cubit.dart';

abstract class ServiciosPublicosViviendaByDptoState extends Equatable {
  final List<ServicioPublicoViviendaEntity>? serviciosPublicosViviendaByDpto;
  const ServiciosPublicosViviendaByDptoState(
      {this.serviciosPublicosViviendaByDpto});

  @override
  List<Object> get props => [];
}

class ServiciosPublicosViviendaByDptoInitial
    extends ServiciosPublicosViviendaByDptoState {}

class ServiciosPublicosViviendaByDptoLoading
    extends ServiciosPublicosViviendaByDptoState {}

class ServiciosPublicosViviendaByDptoLoaded
    extends ServiciosPublicosViviendaByDptoState {
  final List<ServicioPublicoViviendaEntity>?
      serviciosPublicosViviendaByDptoLoaded;

  const ServiciosPublicosViviendaByDptoLoaded(
      this.serviciosPublicosViviendaByDptoLoaded)
      : super(
            serviciosPublicosViviendaByDpto:
                serviciosPublicosViviendaByDptoLoaded);
}

class ServiciosPublicosViviendaByDptoError
    extends ServiciosPublicosViviendaByDptoState {
  final String message;

  const ServiciosPublicosViviendaByDptoError(this.message);
}
