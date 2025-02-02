part of 'servicio_publico_vivienda_cubit.dart';

abstract class ServiciosPublicosViviendaState extends Equatable {
  final List<ServicioPublicoViviendaEntity>? serviciosPublicosVivienda;
  const ServiciosPublicosViviendaState({this.serviciosPublicosVivienda});

  @override
  List<Object> get props => [];
}

class ServiciosPublicosViviendaInitial extends ServiciosPublicosViviendaState {}

class ServiciosPublicosViviendaLoading extends ServiciosPublicosViviendaState {}

class ServiciosPublicosViviendaLoaded extends ServiciosPublicosViviendaState {
  final List<ServicioPublicoViviendaEntity>? serviciosPublicosViviendaLoaded;

  const ServiciosPublicosViviendaLoaded(this.serviciosPublicosViviendaLoaded)
      : super(serviciosPublicosVivienda: serviciosPublicosViviendaLoaded);
}

class ServiciosPublicosViviendaError extends ServiciosPublicosViviendaState {
  final String message;

  const ServiciosPublicosViviendaError(this.message);
}
