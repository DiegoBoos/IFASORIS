import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/metodo_planificacion_entity.dart';
import '../../../domain/usecases/metodo_planificacion/metodo_planificacion_db_usecase.dart';

part 'metodo_planificacion_state.dart';

class MetodoPlanificacionCubit extends Cubit<MetodosPlanificacionState> {
  final MetodoPlanificacionUsecaseDB metodoPlanificacionUsecaseDB;

  MetodoPlanificacionCubit({required this.metodoPlanificacionUsecaseDB})
      : super(MetodosPlanificacionInitial());

  void getMetodoPlanificacionDB() async {
    final result =
        await metodoPlanificacionUsecaseDB.getMetodosPlanificacionUsecaseDB();
    result.fold(
        (failure) => emit(MetodosPlanificacionError(failure.properties.first)),
        (data) => emit(MetodosPlanificacionLoaded(data)));
  }
}
