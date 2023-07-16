import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/actividad_fisica_entity.dart';
import '../../../domain/usecases/actividad_fisica/actividad_fisica_db_usecase.dart';

part 'actividad_fisica_state.dart';

class ActividadFisicaCubit extends Cubit<ActividadesFisicasState> {
  final ActividadFisicaUsecaseDB actividadFisicaUsecaseDB;

  ActividadFisicaCubit({required this.actividadFisicaUsecaseDB})
      : super(ActividadesFisicasInitial());

  void getActividadFisicaDB() async {
    final result =
        await actividadFisicaUsecaseDB.getActividadesFisicasUsecaseDB();
    result.fold(
        (failure) => emit(ActividadesFisicasError(failure.properties.first)),
        (data) => emit(ActividadesFisicasLoaded(data)));
  }
}
