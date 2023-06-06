import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/tipo_combustible_vivienda_model.dart';

import '../../../domain/entities/tipo_combustible_vivienda_entity.dart';
import '../../../domain/usecases/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_db_usecase.dart';

part 'tipo_combustible_vivienda_by_dpto_state.dart';

class TipoCombustibleViviendaByDptoCubit
    extends Cubit<TiposCombustibleViviendaByDptoState> {
  final TipoCombustibleViviendaByDptoUsecaseDB
      tipoCombustibleViviendaByDptoUsecaseDB;

  TipoCombustibleViviendaByDptoCubit(
      {required this.tipoCombustibleViviendaByDptoUsecaseDB})
      : super(TiposCombustibleViviendaByDptoInitial());

  void getTiposCombustibleViviendaByDptoDB() async {
    final result = await tipoCombustibleViviendaByDptoUsecaseDB
        .getTiposCombustibleViviendaByDptoUsecaseDB();
    result.fold(
        (failure) =>
            emit(TiposCombustibleViviendaByDptoError(failure.properties.first)),
        (data) => emit(TiposCombustibleViviendaByDptoLoaded(data)));
  }

  Future<List<LstTiposCombustible>> getTiposCombustibleViviendaDB(
      int? datoViviendaId) async {
    final result = await tipoCombustibleViviendaByDptoUsecaseDB
        .getTiposCombustibleViviendaUsecaseDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
