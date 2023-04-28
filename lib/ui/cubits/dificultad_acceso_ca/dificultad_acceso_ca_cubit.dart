import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_db_usecase.dart';

import '../../../domain/entities/dificultad_acceso_ca_entity.dart';

part 'dificultad_acceso_ca_state.dart';

class DificultadAccesoCACubit extends Cubit<DificultadesAccesoCAState> {
  final DificultadAccesoCAUsecaseDB dificultadAccesoCAUsecaseDB;
  DificultadAccesoCACubit({required this.dificultadAccesoCAUsecaseDB})
      : super(DificultadesAccesoCAInitial());

  void getDificultadesAccesoCA() async {
    final result =
        await dificultadAccesoCAUsecaseDB.getDificultadesAccesoCAUsecase();
    result.fold(
        (failure) => emit(DificultadesAccesoCAError(failure.properties.first)),
        (data) => emit(DificultadesAccesoCALoaded(data)));
  }
}
