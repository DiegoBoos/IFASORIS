import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/ventilacion_vivienda_entity.dart';
import '../../../domain/usecases/ventilacion_vivienda/ventilacion_vivienda_db_usecase.dart';

part 'ventilacion_vivienda_state.dart';

class VentilacionViviendaCubit extends Cubit<VentilacionesViviendaState> {
  final VentilacionViviendaUsecaseDB ventilacionViviendaUsecaseDB;

  VentilacionViviendaCubit({required this.ventilacionViviendaUsecaseDB})
      : super(VentilacionesViviendaInitial());

  void getVentilacionesViviendaDB() async {
    final result =
        await ventilacionViviendaUsecaseDB.getVentilacionesViviendaUsecaseDB();
    result.fold(
        (failure) => emit(VentilacionesViviendaError(failure.properties.first)),
        (data) => emit(VentilacionesViviendaLoaded(data)));
  }
}
