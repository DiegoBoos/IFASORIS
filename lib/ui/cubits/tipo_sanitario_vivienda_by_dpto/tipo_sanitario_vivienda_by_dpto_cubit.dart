import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/tipo_sanitario_vivienda_model.dart';

import '../../../domain/entities/tipo_sanitario_vivienda_entity.dart';
import '../../../domain/usecases/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_db_usecase.dart';

part 'tipo_sanitario_vivienda_by_dpto_state.dart';

class TipoSanitarioViviendaByDptoCubit
    extends Cubit<TiposSanitarioViviendaByDptoState> {
  final TipoSanitarioViviendaByDptoUsecaseDB
      tipoSanitarioViviendaByDptoUsecaseDB;

  TipoSanitarioViviendaByDptoCubit(
      {required this.tipoSanitarioViviendaByDptoUsecaseDB})
      : super(TiposSanitarioViviendaByDptoInitial());

  void getTiposSanitarioViviendaByDptoDB() async {
    final result = await tipoSanitarioViviendaByDptoUsecaseDB
        .getTiposSanitarioViviendaByDptoUsecaseDB();
    result.fold(
        (failure) =>
            emit(TiposSanitarioViviendaByDptoError(failure.properties.first)),
        (data) => emit(TiposSanitarioViviendaByDptoLoaded(data)));
  }

  Future<List<LstTiposSanitario>> getTiposSanitarioViviendaDB(
      int? datoViviendaId) async {
    final result = await tipoSanitarioViviendaByDptoUsecaseDB
        .getTiposSanitarioViviendaUsecaseDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
