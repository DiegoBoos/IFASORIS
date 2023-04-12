import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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
}
