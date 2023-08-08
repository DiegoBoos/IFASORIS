import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/factor_riesgo_vivienda_model.dart';

import '../../../domain/entities/factor_riesgo_vivienda_entity.dart';
import '../../../domain/usecases/factor_riesgo_vivienda/factor_riesgo_vivienda_db_usecase.dart';

part 'factor_riesgo_vivienda_state.dart';

class FactorRiesgoViviendaCubit extends Cubit<FactoresRiesgoViviendaState> {
  final FactorRiesgoViviendaUsecaseDB factorRiesgoViviendaUsecaseDB;

  FactorRiesgoViviendaCubit({required this.factorRiesgoViviendaUsecaseDB})
      : super(FactoresRiesgoViviendaInitial());

  void getFactoresRiesgoDB() async {
    final result =
        await factorRiesgoViviendaUsecaseDB.getFactoresRiesgoUsecaseDB();
    result.fold(
        (failure) =>
            emit(FactoresRiesgoViviendaError(failure.properties.first)),
        (data) => emit(FactoresRiesgoViviendaLoaded(data)));
  }

  Future<List<LstFactoresRiesgo>> getFactoresRiesgoViviendaDB(
      int? datoViviendaId) async {
    final result = await factorRiesgoViviendaUsecaseDB
        .getFactoresRiesgoViviendaUsecaseDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
