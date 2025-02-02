import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tiempo_tarda_med_tradicional.dart';
import '../../../domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_db_usecase.dart';

part 'tiempo_tarda_med_tradicional_state.dart';

class TiempoTardaMedTradicionalCubit
    extends Cubit<TiemposTardaMedTradicionalState> {
  final TiempoTardaMedTradicionalUsecaseDB tiempoTardaMedTradicionalUsecaseDB;
  TiempoTardaMedTradicionalCubit(
      {required this.tiempoTardaMedTradicionalUsecaseDB})
      : super(TiemposTardaMedTradicionalInitial());

  void getTiemposTardaMedTradicionalDB() async {
    final result = await tiempoTardaMedTradicionalUsecaseDB
        .getTiemposTardaMedTradicionalUsecase();
    result.fold(
        (failure) =>
            emit(TiemposTardaMedTradicionalError(failure.properties.first)),
        (data) => emit(TiemposTardaMedTradicionalLoaded(data)));
  }
}
