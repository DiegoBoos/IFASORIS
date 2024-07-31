import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/alimentacion.dart';
import '../../../domain/usecases/alimentacion/alimentacion_db_usecase.dart';

part 'alimentacion_state.dart';

class AlimentacionCubit extends Cubit<AlimentacionesState> {
  final AlimentacionUsecaseDB alimentacionUsecaseDB;

  AlimentacionCubit({required this.alimentacionUsecaseDB})
      : super(AlimentacionesInitial());

  void getAlimentacionDB() async {
    final result = await alimentacionUsecaseDB.getAlimentacionesUsecaseDB();
    result.fold(
        (failure) => emit(AlimentacionesError(failure.properties.first)),
        (data) => emit(AlimentacionesLoaded(data)));
  }
}
