import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_db_usecase.dart';

import '../../../domain/entities/tiempo_tarda_ca.dart';

part 'tiempo_tarda_ca_state.dart';

class TiempoTardaCACubit extends Cubit<TiemposTardaCAState> {
  final TiempoTardaCAUsecaseDB tiempoTardaCAUsecaseDB;
  TiempoTardaCACubit({required this.tiempoTardaCAUsecaseDB})
      : super(TiemposTardaCAInitial());

  void getTiemposTardaCADB() async {
    final result = await tiempoTardaCAUsecaseDB.getTiemposTardaCAUsecase();
    result.fold(
        (failure) => emit(TiemposTardaCAError(failure.properties.first)),
        (data) => emit(TiemposTardaCALoaded(data)));
  }
}
