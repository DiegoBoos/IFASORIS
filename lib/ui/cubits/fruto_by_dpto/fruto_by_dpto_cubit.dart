import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/fruto_model.dart';

import '../../../domain/entities/fruto_entity.dart';
import '../../../domain/usecases/fruto_by_dpto/fruto_by_dpto_db_usecase.dart';

part 'fruto_by_dpto_state.dart';

class FrutoByDptoCubit extends Cubit<FrutosByDptoState> {
  final FrutoByDptoUsecaseDB frutoByDptoUsecaseDB;

  FrutoByDptoCubit({required this.frutoByDptoUsecaseDB})
      : super(FrutosByDptoInitial());

  void getFrutosByDptoDB() async {
    final result = await frutoByDptoUsecaseDB.getFrutosByDptoUsecaseDB();
    result.fold((failure) => emit(FrutosByDptoError(failure.properties.first)),
        (data) => emit(FrutosByDptoLoaded(data)));
  }

  Future<List<LstFruto>> getUbicacionFrutosDB(int? ubicacionId) async {
    final result =
        await frutoByDptoUsecaseDB.getUbicacionFrutosUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
