import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/lugar_atencion_medico_model.dart';

import '../../../domain/entities/lugar_atencion_medico_entity.dart';
import '../../../domain/usecases/lugar_atencion_medico/lugar_atencion_medico_db_usecase.dart';

part 'lugar_atencion_medico_state.dart';

class LugarAtencionMedicoCubit extends Cubit<LugaresAtencionMedicoState> {
  final LugarAtencionMedicoUsecaseDB lugarAtencionMedicoUsecaseDB;

  LugarAtencionMedicoCubit({required this.lugarAtencionMedicoUsecaseDB})
      : super(LugaresAtencionMedicoInitial());

  void getLugaresAtencionMedicoDB() async {
    final result =
        await lugarAtencionMedicoUsecaseDB.getLugaresAtencionMedicoUsecaseDB();
    result.fold(
        (failure) => emit(LugaresAtencionMedicoError(failure.properties.first)),
        (data) => emit(LugaresAtencionMedicoLoaded(data)));
  }

  Future<List<LstLugarAtencionMedico>> getLugaresAtencionMedicoAtencionSaludDB(
      int? atencionSaludId) async {
    final result = await lugarAtencionMedicoUsecaseDB
        .getLugaresAtencionMedicoAtencionSaludUsecaseDB(atencionSaludId);
    return result.fold((failure) => [], (data) => data);
  }
}
