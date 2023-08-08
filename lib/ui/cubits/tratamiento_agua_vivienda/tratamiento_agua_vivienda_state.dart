part of 'tratamiento_agua_vivienda_cubit.dart';

abstract class TratamientosAguaViviendaState extends Equatable {
  final List<TratamientoAguaViviendaEntity>? tratamientosAguaVivienda;
  const TratamientosAguaViviendaState({this.tratamientosAguaVivienda});

  @override
  List<Object> get props => [];
}

class TratamientosAguaViviendaInitial extends TratamientosAguaViviendaState {}

class TratamientosAguaViviendaLoading extends TratamientosAguaViviendaState {}

class TratamientosAguaViviendaLoaded extends TratamientosAguaViviendaState {
  final List<TratamientoAguaViviendaEntity>? tratamientosAguaViviendaLoaded;

  const TratamientosAguaViviendaLoaded(this.tratamientosAguaViviendaLoaded)
      : super(tratamientosAguaVivienda: tratamientosAguaViviendaLoaded);
}

class TratamientosAguaViviendaError extends TratamientosAguaViviendaState {
  final String message;

  const TratamientosAguaViviendaError(this.message);
}
