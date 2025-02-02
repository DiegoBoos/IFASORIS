import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/enfermedad_tratamiento.dart';
import '../../../domain/usecases/enfermedad_tratamiento/enfermedad_tratamiento_db_usecase.dart';

part 'enfermedad_tratamiento_state.dart';

class EnfermedadTratamientoCubit extends Cubit<EnfermedadesTratamientoState> {
  final EnfermedadTratamientoUsecaseDB enfermedadTratamientoUsecaseDB;

  EnfermedadTratamientoCubit({required this.enfermedadTratamientoUsecaseDB})
      : super(EnfermedadesTratamientoInitial());

  void getEnfermedadTratamientoDB() async {
    final result = await enfermedadTratamientoUsecaseDB
        .getEnfermedadesTratamientoUsecaseDB();
    result.fold(
        (failure) =>
            emit(EnfermedadesTratamientoError(failure.properties.first)),
        (data) => emit(EnfermedadesTratamientoLoaded(data)));
  }
}
