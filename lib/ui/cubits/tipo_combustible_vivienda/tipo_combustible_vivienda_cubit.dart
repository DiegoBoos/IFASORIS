import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/tipo_combustible_vivienda_model.dart';

import '../../../domain/entities/tipo_combustible_vivienda_entity.dart';
import '../../../domain/usecases/tipo_combustible_vivienda/tipo_combustible_vivienda_db_usecase.dart';

part 'tipo_combustible_vivienda_state.dart';

class TipoCombustibleViviendaCubit
    extends Cubit<TiposCombustibleViviendaState> {
  final TipoCombustibleViviendaUsecaseDB tipoCombustibleViviendaUsecaseDB;

  TipoCombustibleViviendaCubit({required this.tipoCombustibleViviendaUsecaseDB})
      : super(TiposCombustibleViviendaInitial());

  void getTiposCombustibleDB() async {
    final result =
        await tipoCombustibleViviendaUsecaseDB.getTiposCombustibleUsecaseDB();
    result.fold(
        (failure) =>
            emit(TiposCombustibleViviendaError(failure.properties.first)),
        (data) => emit(TiposCombustibleViviendaLoaded(data)));
  }

  Future<List<LstTiposCombustible>> getTiposCombustibleViviendaDB(
      int? datoViviendaId) async {
    final result = await tipoCombustibleViviendaUsecaseDB
        .getTiposCombustibleViviendaUsecaseDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
