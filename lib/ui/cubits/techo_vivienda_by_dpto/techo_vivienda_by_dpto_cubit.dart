import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/techo_vivienda_model.dart';

import '../../../domain/entities/techo_vivienda_entity.dart';
import '../../../domain/usecases/techo_vivienda_by_dpto/techo_vivienda_by_dpto_db_usecase.dart';

part 'techo_vivienda_by_dpto_state.dart';

class TechoViviendaByDptoCubit extends Cubit<TechosViviendaByDptoState> {
  final TechoViviendaByDptoUsecaseDB techoViviendaByDptoUsecaseDB;

  TechoViviendaByDptoCubit({required this.techoViviendaByDptoUsecaseDB})
      : super(TechosViviendaByDptoInitial());

  void getTechosViviendaByDptoDB() async {
    final result =
        await techoViviendaByDptoUsecaseDB.getTechosViviendaByDptoUsecaseDB();
    result.fold(
        (failure) => emit(TechosViviendaByDptoError(failure.properties.first)),
        (data) => emit(TechosViviendaByDptoLoaded(data)));
  }

  Future<List<LstTecho>> getTechosViviendaDB(int? datoViviendaId) async {
    final result = await techoViviendaByDptoUsecaseDB
        .getTechosViviendaUsecaseDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
