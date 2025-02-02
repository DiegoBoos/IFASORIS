part of 'ventilacion_vivienda_cubit.dart';

abstract class VentilacionesViviendaState extends Equatable {
  final List<VentilacionViviendaEntity>? ventilacionesVivienda;
  const VentilacionesViviendaState({this.ventilacionesVivienda});

  @override
  List<Object> get props => [];
}

class VentilacionesViviendaInitial extends VentilacionesViviendaState {}

class VentilacionesViviendaLoading extends VentilacionesViviendaState {}

class VentilacionesViviendaLoaded extends VentilacionesViviendaState {
  final List<VentilacionViviendaEntity>? ventilacionesViviendaLoaded;

  const VentilacionesViviendaLoaded(this.ventilacionesViviendaLoaded)
      : super(ventilacionesVivienda: ventilacionesViviendaLoaded);
}

class VentilacionesViviendaError extends VentilacionesViviendaState {
  final String message;

  const VentilacionesViviendaError(this.message);
}
