import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/factor_riesgo_vivienda_entity.dart';
import '../../../domain/usecases/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_db_usecase.dart';

part 'factor_riesgo_vivienda_by_dpto_state.dart';

class FactorRiesgoViviendaByDptoCubit
    extends Cubit<FactoresRiesgoViviendaByDptoState> {
  final FactorRiesgoViviendaByDptoUsecaseDB factorRiesgoViviendaByDptoUsecaseDB;

  FactorRiesgoViviendaByDptoCubit(
      {required this.factorRiesgoViviendaByDptoUsecaseDB})
      : super(FactoresRiesgoViviendaByDptoInitial());

  void getFactoresRiesgoViviendaByDptoDB() async {
    final result = await factorRiesgoViviendaByDptoUsecaseDB
        .getFactoresRiesgoViviendaByDptoUsecaseDB();
    result.fold(
        (failure) =>
            emit(FactoresRiesgoViviendaByDptoError(failure.properties.first)),
        (data) => emit(FactoresRiesgoViviendaByDptoLoaded(data)));
  }
}
