import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/opcion_si_no.dart';
import '../../../domain/usecases/opcion_si_no/opcion_si_no_db_usecase.dart';

part 'opcion_si_no_state.dart';

class OpcionSiNoCubit extends Cubit<OpcionesSiNoState> {
  final OpcionSiNoUsecaseDB opcionSiNoUsecaseDB;

  OpcionSiNoCubit({required this.opcionSiNoUsecaseDB})
      : super(OpcionesSiNoInitial());

  void getOpcionesSiNoDB() async {
    final result = await opcionSiNoUsecaseDB.getOpcionesSiNoUsecase();
    result.fold((failure) => emit(OpcionesSiNoError(failure.properties.first)),
        (data) => emit(OpcionesSiNoLoaded(data)));
  }
}
