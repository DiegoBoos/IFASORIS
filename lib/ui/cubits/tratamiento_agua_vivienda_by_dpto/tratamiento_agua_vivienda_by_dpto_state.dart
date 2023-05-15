part of 'tratamiento_agua_vivienda_by_dpto_cubit.dart';

abstract class TratamientosAguaViviendaByDptoState extends Equatable {
  final List<TratamientoAguaViviendaEntity>? tratamientosAguaViviendaByDpto;
  const TratamientosAguaViviendaByDptoState(
      {this.tratamientosAguaViviendaByDpto});

  @override
  List<Object> get props => [];
}

class TratamientosAguaViviendaByDptoInitial
    extends TratamientosAguaViviendaByDptoState {}

class TratamientosAguaViviendaByDptoLoading
    extends TratamientosAguaViviendaByDptoState {}

class TratamientosAguaViviendaByDptoLoaded
    extends TratamientosAguaViviendaByDptoState {
  final List<TratamientoAguaViviendaEntity>?
      tratamientosAguaViviendaByDptoLoaded;

  const TratamientosAguaViviendaByDptoLoaded(
      this.tratamientosAguaViviendaByDptoLoaded)
      : super(
            tratamientosAguaViviendaByDpto:
                tratamientosAguaViviendaByDptoLoaded);
}

class TratamientosAguaViviendaByDptoError
    extends TratamientosAguaViviendaByDptoState {
  final String message;

  const TratamientosAguaViviendaByDptoError(this.message);
}
