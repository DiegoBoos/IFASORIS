import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/piso_vivienda_entity.dart';
import '../../../domain/usecases/piso_vivienda/piso_vivienda_db_usecase.dart';

part 'piso_vivienda_state.dart';

class PisoViviendaCubit extends Cubit<PisosViviendaState> {
  final PisoViviendaUsecaseDB pisoViviendaUsecaseDB;

  PisoViviendaCubit({required this.pisoViviendaUsecaseDB})
      : super(PisosViviendaInitial());

  void getPisosViviendaDB() async {
    final result = await pisoViviendaUsecaseDB.getPisosViviendaUsecaseDB();
    result.fold((failure) => emit(PisosViviendaError(failure.properties.first)),
        (data) => emit(PisosViviendaLoaded(data)));
  }
}
