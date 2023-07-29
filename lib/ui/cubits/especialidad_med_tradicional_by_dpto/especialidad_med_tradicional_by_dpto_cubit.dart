import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/especialidad_med_tradicional_model.dart';
import 'package:ifasoris/data/models/nombre_med_tradicional_model.dart';

import '../../../domain/entities/especialidad_med_tradicional_entity.dart';
import '../../../domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_db_usecase.dart';

part 'especialidad_med_tradicional_by_dpto_state.dart';

class EspecialidadMedTradicionalCubit
    extends Cubit<EspecialidadesMedTradicionalState> {
  final EspecialidadMedTradicionalUsecaseDB especialidadMedTradicionalUsecaseDB;

  EspecialidadMedTradicionalCubit(
      {required this.especialidadMedTradicionalUsecaseDB})
      : super(EspecialidadesMedTradicionalInitial());

  void getEspecialidadesMedTradicionalDB() async {
    final result = await especialidadMedTradicionalUsecaseDB
        .getEspecialidadesMedTradicionalUsecaseDB();
    result.fold(
        (failure) =>
            emit(EspecialidadesMedTradicionalError(failure.properties.first)),
        (data) => emit(EspecialidadesMedTradicionalLoaded(data)));
  }

  Future<List<LstEspMedTradicional>> getUbicacionEspecialidadesMedTradicionalDB(
      int? ubicacionId) async {
    final result = await especialidadMedTradicionalUsecaseDB
        .getUbicacionEspecialidadesMedTradicionalUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }

  Future<List<LstNombreMedTradicional>> getUbicacionNombresMedTradicionalDB(
      int? ubicacionId) async {
    final result = await especialidadMedTradicionalUsecaseDB
        .getUbicacionNombresMedTradicionalUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }

  Future<List<LstEspMedTradicional>>
      getEspecialidadesMedTradicionalAtencionSaludDB(
          int? atencionSaludId) async {
    final result = await especialidadMedTradicionalUsecaseDB
        .getEspecialidadesMedTradicionalAtencionSaludUsecaseDB(atencionSaludId);
    return result.fold((failure) => [], (data) => data);
  }
}
