import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/presencia_animal_vivienda.dart';

import '../../../domain/entities/presencia_animal_vivienda.dart';
import '../../../domain/usecases/presencia_animal_vivienda/presencia_animal_vivienda_db_usecase.dart';

part 'presencia_animal_vivienda_state.dart';

class PresenciaAnimalViviendaCubit
    extends Cubit<PresenciaAnimalesViviendaState> {
  final PresenciaAnimalViviendaUsecaseDB presenciaAnimalViviendaUsecaseDB;

  PresenciaAnimalViviendaCubit({required this.presenciaAnimalViviendaUsecaseDB})
      : super(PresenciaAnimalesViviendaInitial());

  void getPresenciaAnimalesDB() async {
    final result =
        await presenciaAnimalViviendaUsecaseDB.getPresenciaAnimalesUsecaseDB();
    result.fold(
        (failure) =>
            emit(PresenciaAnimalesViviendaError(failure.properties.first)),
        (data) => emit(PresenciaAnimalesViviendaLoaded(data)));
  }

  Future<List<LstPresenciaAnimal>> getPresenciasAnimalesViviendaDB(
      int? datoViviendaId) async {
    final result = await presenciaAnimalViviendaUsecaseDB
        .getPresenciaAnimalesViviendaUsecaseDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
