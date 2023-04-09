import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/especialidad_med_tradicional_by_dpto_entity.dart';
import '../../../domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_db_usecase.dart';

part 'especialidad_med_tradicional_by_dpto_state.dart';

class EspecialidadMedTradicionalByDptoCubit
    extends Cubit<EspecialidadesMedTradicionalByDptoState> {
  final EspecialidadMedTradicionalByDptoUsecaseDB
      especialidadmedtradicionalByDptoUsecaseDB;

  EspecialidadMedTradicionalByDptoCubit(
      {required this.especialidadmedtradicionalByDptoUsecaseDB})
      : super(EspecialidadesMedTradicionalByDptoInitial());

  void getEspecialidadesMedTradicionalByDptoDB(int dtoId) async {
    final result = await especialidadmedtradicionalByDptoUsecaseDB
        .getEspecialidadesMedTradicionalByDptoUsecaseDB(dtoId);
    result.fold(
        (failure) => emit(
            EspecialidadesMedTradicionalByDptoError(failure.properties.first)),
        (data) => emit(EspecialidadesMedTradicionalByDptoLoaded(data)));
  }
}
