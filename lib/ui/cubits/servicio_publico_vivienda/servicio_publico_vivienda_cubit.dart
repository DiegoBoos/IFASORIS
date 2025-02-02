import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/servicio_publico_vivienda.dart';

import '../../../domain/entities/servicio_publico_vivienda.dart';
import '../../../domain/usecases/servicio_publico_vivienda/servicio_publico_vivienda_db_usecase.dart';

part 'servicio_publico_vivienda_state.dart';

class ServicioPublicoViviendaCubit
    extends Cubit<ServiciosPublicosViviendaState> {
  final ServicioPublicoViviendaUsecaseDB servicioPublicoViviendaUsecaseDB;

  ServicioPublicoViviendaCubit({required this.servicioPublicoViviendaUsecaseDB})
      : super(ServiciosPublicosViviendaInitial());

  void getServiciosPublicosDB() async {
    final result =
        await servicioPublicoViviendaUsecaseDB.getServiciosPublicosUsecaseDB();
    result.fold(
        (failure) =>
            emit(ServiciosPublicosViviendaError(failure.properties.first)),
        (data) => emit(ServiciosPublicosViviendaLoaded(data)));
  }

  Future<List<LstServPublico>> getServiciosPublicosViviendaDB(
      int? datoViviendaId) async {
    final result = await servicioPublicoViviendaUsecaseDB
        .getServiciosPublicosViviendaDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
