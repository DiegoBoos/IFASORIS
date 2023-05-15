import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tratamiento_agua_vivienda_entity.dart';
import '../../../domain/usecases/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_db_usecase.dart';

part 'tratamiento_agua_vivienda_by_dpto_state.dart';

class TratamientoAguaViviendaByDptoCubit
    extends Cubit<TratamientosAguaViviendaByDptoState> {
  final TratamientoAguaViviendaByDptoUsecaseDB
      tratamientoAguaViviendaByDptoUsecaseDB;

  TratamientoAguaViviendaByDptoCubit(
      {required this.tratamientoAguaViviendaByDptoUsecaseDB})
      : super(TratamientosAguaViviendaByDptoInitial());

  void getTratamientosAguaViviendaByDptoDB() async {
    final result = await tratamientoAguaViviendaByDptoUsecaseDB
        .getTratamientosAguaViviendaByDptoUsecaseDB();
    result.fold(
        (failure) =>
            emit(TratamientosAguaViviendaByDptoError(failure.properties.first)),
        (data) => emit(TratamientosAguaViviendaByDptoLoaded(data)));
  }
}
