import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/servicio_publico_vivienda_entity.dart';
import '../../../domain/usecases/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_db_usecase.dart';

part 'servicio_publico_vivienda_by_dpto_state.dart';

class ServicioPublicoViviendaByDptoCubit
    extends Cubit<ServiciosPublicosViviendaByDptoState> {
  final ServicioPublicoViviendaByDptoUsecaseDB
      servicioPublicoViviendaByDptoUsecaseDB;

  ServicioPublicoViviendaByDptoCubit(
      {required this.servicioPublicoViviendaByDptoUsecaseDB})
      : super(ServiciosPublicosViviendaByDptoInitial());

  void getServiciosPublicosViviendaByDptoDB() async {
    final result = await servicioPublicoViviendaByDptoUsecaseDB
        .getServiciosPublicosViviendaByDptoUsecaseDB();
    result.fold(
        (failure) => emit(
            ServiciosPublicosViviendaByDptoError(failure.properties.first)),
        (data) => emit(ServiciosPublicosViviendaByDptoLoaded(data)));
  }
}
