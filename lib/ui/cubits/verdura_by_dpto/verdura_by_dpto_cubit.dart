import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/verdura_model.dart';

import '../../../domain/entities/verdura_entity.dart';
import '../../../domain/usecases/verdura_by_dpto/verdura_by_dpto_db_usecase.dart';

part 'verdura_by_dpto_state.dart';

class VerduraByDptoCubit extends Cubit<VerdurasByDptoState> {
  final VerduraByDptoUsecaseDB verduraByDptoUsecaseDB;

  VerduraByDptoCubit({required this.verduraByDptoUsecaseDB})
      : super(VerdurasByDptoInitial());

  void getVerdurasByDptoDB() async {
    final result = await verduraByDptoUsecaseDB.getVerdurasByDptoUsecaseDB();
    result.fold(
        (failure) => emit(VerdurasByDptoError(failure.properties.first)),
        (data) => emit(VerdurasByDptoLoaded(data)));
  }

  Future<List<LstVerdura>> getUbicacionVerdurasDB(int? ubicacionId) async {
    final result =
        await verduraByDptoUsecaseDB.getUbicacionVerdurasUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
