import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/ocupacion.dart';
import '../../../domain/usecases/ocupacion/ocupacion_db_usecase.dart';

part 'ocupacion_state.dart';

class OcupacionCubit extends Cubit<OcupacionesState> {
  final OcupacionUsecaseDB ocupacionUsecaseDB;

  OcupacionCubit({required this.ocupacionUsecaseDB})
      : super(OcupacionesInitial());

  void getOcupacionesDB() async {
    final result = await ocupacionUsecaseDB.getOcupacionesUsecaseDB();
    result.fold((failure) => emit(OcupacionesError(failure.properties.first)),
        (data) => emit(OcupacionesLoaded(data)));
  }
}
