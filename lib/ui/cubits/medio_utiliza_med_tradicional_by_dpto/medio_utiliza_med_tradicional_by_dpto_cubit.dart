import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/medio_utiliza_med_tradicional_entity.dart';
import '../../../domain/usecases/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_db_usecase.dart';

part 'medio_utiliza_med_tradicional_by_dpto_state.dart';

class MedioUtilizaMedTradicionalByDptoCubit
    extends Cubit<MediosUtilizaMedTradicionalByDptoState> {
  final MedioUtilizaMedTradicionalByDptoUsecaseDB
      medioUtilizaMedTradicionalByDptoUsecaseDB;

  MedioUtilizaMedTradicionalByDptoCubit(
      {required this.medioUtilizaMedTradicionalByDptoUsecaseDB})
      : super(MediosUtilizaMedTradicionalByDptoInitial());

  void getMediosUtilizaMedTradicionalByDpto() async {
    final result = await medioUtilizaMedTradicionalByDptoUsecaseDB
        .getMediosUtilizaMedTradicionalByDptoUsecase();
    result.fold(
        (failure) => emit(
            MediosUtilizaMedTradicionalByDptoError(failure.properties.first)),
        (data) => emit(MediosUtilizaMedTradicionalByDptoLoaded(data)));
  }
}
