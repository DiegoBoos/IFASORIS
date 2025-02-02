import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/data/models/servicio_solicitado.dart';

import '../../../domain/entities/servicio_solicitado.dart';
import '../../../domain/usecases/servicio_solicitado/servicio_solicitado_db_usecase.dart';

part 'servicio_solicitado_state.dart';

class ServicioSolicitadoCubit extends Cubit<ServiciosSolicitadosState> {
  final ServicioSolicitadoUsecaseDB servicioSolicitadoUsecaseDB;

  ServicioSolicitadoCubit({required this.servicioSolicitadoUsecaseDB})
      : super(ServiciosSolicitadosInitial());

  void getServicioSolicitadoDB() async {
    final result =
        await servicioSolicitadoUsecaseDB.getServiciosSolicitadosUsecaseDB();
    result.fold(
        (failure) => emit(ServiciosSolicitadosError(failure.properties.first)),
        (data) => emit(ServiciosSolicitadosLoaded(data)));
  }

  Future<List<LstServicioSolicitado>> getServiciosSolicitadosDB(
      int? cuidadoSaludCondRiesgoId) async {
    final result = await servicioSolicitadoUsecaseDB
        .getLstServiciosSolicitadosUsecaseDB(cuidadoSaludCondRiesgoId);
    return result.fold((failure) => [], (data) => data);
  }
}
