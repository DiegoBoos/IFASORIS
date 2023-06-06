import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/presencia_animal_vivienda_model.dart';

import '../../../domain/entities/presencia_animal_vivienda_entity.dart';
import '../../../domain/usecases/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_db_usecase.dart';

part 'presencia_animal_vivienda_by_dpto_state.dart';

class PresenciaAnimalViviendaByDptoCubit
    extends Cubit<PresenciaAnimalesViviendaByDptoState> {
  final PresenciaAnimalViviendaByDptoUsecaseDB
      presenciaAnimalViviendaByDptoUsecaseDB;

  PresenciaAnimalViviendaByDptoCubit(
      {required this.presenciaAnimalViviendaByDptoUsecaseDB})
      : super(PresenciaAnimalesViviendaByDptoInitial());

  void getPresenciaAnimalesViviendaDB() async {
    final result = await presenciaAnimalViviendaByDptoUsecaseDB
        .getPresenciaAnimalesViviendaByDptoUsecaseDB();
    result.fold(
        (failure) => emit(
            PresenciaAnimalesViviendaByDptoError(failure.properties.first)),
        (data) => emit(PresenciaAnimalesViviendaByDptoLoaded(data)));
  }

  Future<List<LstPresenciaAnimal>> getPresenciasAnimalesViviendaDB(
      int? datoViviendaId) async {
    final result = await presenciaAnimalViviendaByDptoUsecaseDB
        .getPresenciaAnimalesViviendaUsecaseDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
