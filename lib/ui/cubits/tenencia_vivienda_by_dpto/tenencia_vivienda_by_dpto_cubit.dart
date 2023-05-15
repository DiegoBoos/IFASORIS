import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tenencia_vivienda_entity.dart';
import '../../../domain/usecases/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_db_usecase.dart';

part 'tenencia_vivienda_by_dpto_state.dart';

class TenenciaViviendaByDptoCubit extends Cubit<TenenciasViviendaByDptoState> {
  final TenenciaViviendaByDptoUsecaseDB tenenciaViviendaByDptoUsecaseDB;

  TenenciaViviendaByDptoCubit({required this.tenenciaViviendaByDptoUsecaseDB})
      : super(TenenciasViviendaByDptoInitial());

  void getTenenciasViviendaByDptoDB() async {
    final result = await tenenciaViviendaByDptoUsecaseDB
        .getTenenciasViviendaByDptoUsecaseDB();
    result.fold(
        (failure) =>
            emit(TenenciasViviendaByDptoError(failure.properties.first)),
        (data) => emit(TenenciasViviendaByDptoLoaded(data)));
  }
}
