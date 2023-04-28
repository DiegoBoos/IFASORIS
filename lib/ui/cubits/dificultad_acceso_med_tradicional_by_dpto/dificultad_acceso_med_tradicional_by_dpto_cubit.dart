import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_db_usecase.dart';

part 'dificultad_acceso_med_tradicional_by_dpto_state.dart';

class DificultadAccesoMedTradicionalByDptoCubit
    extends Cubit<DificultadesAccesoMedTradicionalByDptoState> {
  final DificultadAccesoMedTradicionalByDptoUsecaseDB
      dificultadAccesoMedTradicionalByDptoUsecaseDB;
  DificultadAccesoMedTradicionalByDptoCubit(
      {required this.dificultadAccesoMedTradicionalByDptoUsecaseDB})
      : super(DificultadesAccesoMedTradicionalByDptoInitial());

  void getDificultadesAccesoMedTradicionalByDpto() async {
    final result = await dificultadAccesoMedTradicionalByDptoUsecaseDB
        .getDificultadesAccesoMedTradicionalByDptoUsecase();
    result.fold(
        (failure) => emit(DificultadesAccesoMedTradicionalByDptoError(
            failure.properties.first)),
        (data) => emit(DificultadesAccesoMedTradicionalByDptoLoaded(data)));
  }
}
