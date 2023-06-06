import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/cereal_model.dart';

import '../../../domain/entities/cereal_entity.dart';
import '../../../domain/usecases/cereal_by_dpto/cereal_by_dpto_db_usecase.dart';

part 'cereal_by_dpto_state.dart';

class CerealByDptoCubit extends Cubit<CerealesByDptoState> {
  final CerealByDptoUsecaseDB cerealByDptoUsecaseDB;

  CerealByDptoCubit({required this.cerealByDptoUsecaseDB})
      : super(CerealesByDptoInitial());

  void getCerealesByDptoDB() async {
    final result = await cerealByDptoUsecaseDB.getCerealesByDptoUsecaseDB();
    result.fold(
        (failure) => emit(CerealesByDptoError(failure.properties.first)),
        (data) => emit(CerealesByDptoLoaded(data)));
  }

  Future<List<LstCereal>> getUbicacionCerealesDB(int? ubicacionId) async {
    final result =
        await cerealByDptoUsecaseDB.getUbicacionCerealesUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
