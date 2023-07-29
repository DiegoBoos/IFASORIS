import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/seguimiento_enfermedad_entity.dart';
import '../../../domain/usecases/seguimiento_enfermedad/seguimiento_enfermedad_db_usecase.dart';

part 'seguimiento_enfermedad_state.dart';

class SeguimientoEnfermedadCubit extends Cubit<SeguimientoEnfermedadesState> {
  final SeguimientoEnfermedadUsecaseDB seguimientoEnfermedadUsecaseDB;

  SeguimientoEnfermedadCubit({required this.seguimientoEnfermedadUsecaseDB})
      : super(SeguimientoEnfermedadesInitial());

  void getSeguimientoEnfermedadDB() async {
    final result = await seguimientoEnfermedadUsecaseDB
        .getSeguimientoEnfermedadesUsecaseDB();
    result.fold(
        (failure) =>
            emit(SeguimientoEnfermedadesError(failure.properties.first)),
        (data) => emit(SeguimientoEnfermedadesLoaded(data)));
  }
}
