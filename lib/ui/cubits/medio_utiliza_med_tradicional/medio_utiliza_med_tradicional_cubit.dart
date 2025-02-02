import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/data/models/medio_utiliza_med_tradicional.dart';

import '../../../domain/entities/medio_utiliza_med_tradicional.dart';
import '../../../domain/usecases/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_db_usecase.dart';

part 'medio_utiliza_med_tradicional_state.dart';

class MedioUtilizaMedTradicionalCubit
    extends Cubit<MediosUtilizaMedTradicionalState> {
  final MedioUtilizaMedTradicionalUsecaseDB medioUtilizaMedTradicionalUsecaseDB;

  MedioUtilizaMedTradicionalCubit(
      {required this.medioUtilizaMedTradicionalUsecaseDB})
      : super(MediosUtilizaMedTradicionalInitial());

  void getMediosUtilizaMedTradicional() async {
    final result = await medioUtilizaMedTradicionalUsecaseDB
        .getMediosUtilizaMedTradicionalUsecase();
    result.fold(
        (failure) =>
            emit(MediosUtilizaMedTradicionalError(failure.properties.first)),
        (data) => emit(MediosUtilizaMedTradicionalLoaded(data)));
  }

  Future<List<LstMediosMedTradicional>> getMedioUtilizaMedTradicionalDB(
      int? ubicacionId) async {
    final result = await medioUtilizaMedTradicionalUsecaseDB
        .getUbicacionMediosUtilizaMedTradicionalUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
