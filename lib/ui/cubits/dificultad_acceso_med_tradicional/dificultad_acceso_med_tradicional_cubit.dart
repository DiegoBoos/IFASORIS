import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/dificultad_acceso_med_tradicional_model.dart';

import '../../../domain/entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_db_usecase.dart';

part 'dificultad_acceso_med_tradicional_state.dart';

class DificultadAccesoMedTradicionalCubit
    extends Cubit<DificultadesAccesoMedTradicionalState> {
  final DificultadAccesoMedTradicionalUsecaseDB
      dificultadAccesoMedTradicionalUsecaseDB;
  DificultadAccesoMedTradicionalCubit(
      {required this.dificultadAccesoMedTradicionalUsecaseDB})
      : super(DificultadesAccesoMedTradicionalInitial());

  void getDificultadesAccesoMedTradicional() async {
    final result = await dificultadAccesoMedTradicionalUsecaseDB
        .getDificultadesAccesoMedTradicionalUsecase();
    result.fold(
        (failure) => emit(
            DificultadesAccesoMedTradicionalError(failure.properties.first)),
        (data) => emit(DificultadesAccesoMedTradicionalLoaded(data)));
  }

  Future<List<LstDificultadAccesoMedTradicional>>
      getUbicacionDificultadAccesoMedTradicionalDB(int? ubicacionId) async {
    final result = await dificultadAccesoMedTradicionalUsecaseDB
        .getUbicacionDificultadesAccesoMedTradicionalUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
