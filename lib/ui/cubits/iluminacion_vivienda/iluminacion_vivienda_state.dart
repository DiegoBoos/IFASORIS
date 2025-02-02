part of 'iluminacion_vivienda_cubit.dart';

abstract class IluminacionesViviendaState extends Equatable {
  final List<IluminacionViviendaEntity>? iluminacionesVivienda;
  const IluminacionesViviendaState({this.iluminacionesVivienda});

  @override
  List<Object> get props => [];
}

class IluminacionesViviendaInitial extends IluminacionesViviendaState {}

class IluminacionesViviendaLoading extends IluminacionesViviendaState {}

class IluminacionesViviendaLoaded extends IluminacionesViviendaState {
  final List<IluminacionViviendaEntity>? iluminacionesViviendaLoaded;

  const IluminacionesViviendaLoaded(this.iluminacionesViviendaLoaded)
      : super(iluminacionesVivienda: iluminacionesViviendaLoaded);
}

class IluminacionesViviendaError extends IluminacionesViviendaState {
  final String message;

  const IluminacionesViviendaError(this.message);
}
