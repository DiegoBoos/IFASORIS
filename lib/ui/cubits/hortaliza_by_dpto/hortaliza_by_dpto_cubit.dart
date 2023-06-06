import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/hortaliza_model.dart';

import '../../../domain/entities/hortaliza_entity.dart';
import '../../../domain/usecases/hortaliza_by_dpto/hortaliza_by_dpto_db_usecase.dart';

part 'hortaliza_by_dpto_state.dart';

class HortalizaByDptoCubit extends Cubit<HortalizasByDptoState> {
  final HortalizaByDptoUsecaseDB hortalizaByDptoUsecaseDB;

  HortalizaByDptoCubit({required this.hortalizaByDptoUsecaseDB})
      : super(HortalizasByDptoInitial());

  void getHortalizasByDptoDB() async {
    final result =
        await hortalizaByDptoUsecaseDB.getHortalizasByDptoUsecaseDB();
    result.fold(
        (failure) => emit(HortalizasByDptoError(failure.properties.first)),
        (data) => emit(HortalizasByDptoLoaded(data)));
  }

  Future<List<LstHortaliza>> getUbicacionHortalizasDB(int? ubicacionId) async {
    final result = await hortalizaByDptoUsecaseDB
        .getUbicacionHortalizasUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
