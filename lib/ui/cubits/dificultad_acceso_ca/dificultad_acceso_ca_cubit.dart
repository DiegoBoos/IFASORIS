import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/dificultad_acceso_ca.dart';
import '../../../domain/entities/dificultad_acceso_ca.dart';
import '../../../domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_db_usecase.dart';

part 'dificultad_acceso_ca_state.dart';

class DificultadAccesoCACubit extends Cubit<DificultadesAccesoCAState> {
  final DificultadAccesoCAUsecaseDB dificultadAccesoCAUsecaseDB;
  DificultadAccesoCACubit({required this.dificultadAccesoCAUsecaseDB})
      : super(DificultadesAccesoCAInitial());

  void getDificultadesAccesoCA() async {
    final result =
        await dificultadAccesoCAUsecaseDB.getDificultadesAccesoCAUsecase();
    result.fold(
        (failure) => emit(DificultadesAccesoCAError(failure.properties.first)),
        (data) => emit(DificultadesAccesoCALoaded(data)));
  }

  Future<List<LstDificultadAccesoAtencion>> getUbicacionDificultadesAccesoCADB(
      int? ubicacionId) async {
    final result = await dificultadAccesoCAUsecaseDB
        .getUbicacionDificultadesAccesoUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
