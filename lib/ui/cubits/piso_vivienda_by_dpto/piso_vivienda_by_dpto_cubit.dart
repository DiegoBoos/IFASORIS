import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/piso_vivienda_entity.dart';
import '../../../domain/usecases/piso_vivienda_by_dpto/piso_vivienda_by_dpto_db_usecase.dart';

part 'piso_vivienda_by_dpto_state.dart';

class PisoViviendaByDptoCubit extends Cubit<PisosViviendaByDptoState> {
  final PisoViviendaByDptoUsecaseDB pisoViviendaByDptoUsecaseDB;

  PisoViviendaByDptoCubit({required this.pisoViviendaByDptoUsecaseDB})
      : super(PisosViviendaByDptoInitial());

  void getPisosViviendaByDptoDB() async {
    final result =
        await pisoViviendaByDptoUsecaseDB.getPisosViviendaByDptoUsecaseDB();
    result.fold(
        (failure) => emit(PisosViviendaByDptoError(failure.properties.first)),
        (data) => emit(PisosViviendaByDptoLoaded(data)));
  }
}
