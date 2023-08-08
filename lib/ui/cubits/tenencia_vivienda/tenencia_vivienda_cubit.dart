import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tenencia_vivienda_entity.dart';
import '../../../domain/usecases/tenencia_vivienda/tenencia_vivienda_db_usecase.dart';

part 'tenencia_vivienda_state.dart';

class TenenciaViviendaCubit extends Cubit<TenenciasViviendaState> {
  final TenenciaViviendaUsecaseDB tenenciaViviendaUsecaseDB;

  TenenciaViviendaCubit({required this.tenenciaViviendaUsecaseDB})
      : super(TenenciasViviendaInitial());

  void getTenenciasViviendaDB() async {
    final result =
        await tenenciaViviendaUsecaseDB.getTenenciasViviendaUsecaseDB();
    result.fold(
        (failure) => emit(TenenciasViviendaError(failure.properties.first)),
        (data) => emit(TenenciasViviendaLoaded(data)));
  }
}
