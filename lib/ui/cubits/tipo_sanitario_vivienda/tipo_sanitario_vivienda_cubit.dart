import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/tipo_sanitario_vivienda_model.dart';

import '../../../domain/entities/tipo_sanitario_vivienda_entity.dart';
import '../../../domain/usecases/tipo_sanitario_vivienda/tipo_sanitario_vivienda_db_usecase.dart';

part 'tipo_sanitario_vivienda_state.dart';

class TipoSanitarioViviendaCubit extends Cubit<TiposSanitarioViviendaState> {
  final TipoSanitarioViviendaUsecaseDB tipoSanitarioViviendaUsecaseDB;

  TipoSanitarioViviendaCubit({required this.tipoSanitarioViviendaUsecaseDB})
      : super(TiposSanitarioViviendaInitial());

  void getTiposSanitarioDB() async {
    final result =
        await tipoSanitarioViviendaUsecaseDB.getTiposSanitarioUsecaseDB();
    result.fold(
        (failure) =>
            emit(TiposSanitarioViviendaError(failure.properties.first)),
        (data) => emit(TiposSanitarioViviendaLoaded(data)));
  }

  Future<List<LstTipoSanitario>> getTiposSanitarioViviendaDB(
      int? datoViviendaId) async {
    final result = await tipoSanitarioViviendaUsecaseDB
        .getTiposSanitarioViviendaUsecaseDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
