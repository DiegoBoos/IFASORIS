import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/tratamiento_agua_vivienda.dart';

import '../../../domain/entities/tratamiento_agua_vivienda.dart';
import '../../../domain/usecases/tratamiento_agua_vivienda/tratamiento_agua_vivienda_db_usecase.dart';

part 'tratamiento_agua_vivienda_state.dart';

class TratamientoAguaViviendaCubit
    extends Cubit<TratamientosAguaViviendaState> {
  final TratamientoAguaViviendaUsecaseDB tratamientoAguaViviendaUsecaseDB;

  TratamientoAguaViviendaCubit({required this.tratamientoAguaViviendaUsecaseDB})
      : super(TratamientosAguaViviendaInitial());

  void getTratamientosAguaDB() async {
    final result =
        await tratamientoAguaViviendaUsecaseDB.getTratamientosAguaUsecaseDB();
    result.fold(
        (failure) =>
            emit(TratamientosAguaViviendaError(failure.properties.first)),
        (data) => emit(TratamientosAguaViviendaLoaded(data)));
  }

  Future<List<LstTmtoAgua>> getTratamientosAguaViviendaDB(
      int? datoViviendaId) async {
    final result = await tratamientoAguaViviendaUsecaseDB
        .getTratamientosAguaViviendaUsecaseDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
