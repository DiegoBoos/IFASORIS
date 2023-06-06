import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/especialidad_med_tradicional_model.dart';
import 'package:ifasoris/data/models/nombre_med_tradicional_model.dart';

import '../../../domain/entities/especialidad_med_tradicional_entity.dart';
import '../../../domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_db_usecase.dart';

part 'especialidad_med_tradicional_by_dpto_state.dart';

class EspecialidadMedTradicionalByDptoCubit
    extends Cubit<EspecialidadesMedTradicionalByDptoState> {
  final EspecialidadMedTradicionalByDptoUsecaseDB
      especialidadMedTradicionalByDptoUsecaseDB;

  EspecialidadMedTradicionalByDptoCubit(
      {required this.especialidadMedTradicionalByDptoUsecaseDB})
      : super(EspecialidadesMedTradicionalByDptoInitial());

  void getEspecialidadesMedTradicionalByDptoDB() async {
    final result = await especialidadMedTradicionalByDptoUsecaseDB
        .getEspecialidadesMedTradicionalByDptoUsecaseDB();
    result.fold(
        (failure) => emit(
            EspecialidadesMedTradicionalByDptoError(failure.properties.first)),
        (data) => emit(EspecialidadesMedTradicionalByDptoLoaded(data)));
  }

  Future<List<LstEspMedTradicional>> getUbicacionEspecialidadesMedTradicionalDB(
      int? ubicacionId) async {
    final result = await especialidadMedTradicionalByDptoUsecaseDB
        .getUbicacionEspecialidadesMedTradicionalUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }

  Future<List<LstNombreMedTradicional>> getUbicacionNombresMedTradicionalDB(
      int? ubicacionId) async {
    final result = await especialidadMedTradicionalByDptoUsecaseDB
        .getUbicacionNombresMedTradicionalUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
