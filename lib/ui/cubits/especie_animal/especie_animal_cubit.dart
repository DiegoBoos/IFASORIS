import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/especie_animal.dart';

import '../../../domain/entities/especie_animal.dart';
import '../../../domain/usecases/especie_animal/especie_animal_db_usecase.dart';

part 'especie_animal_state.dart';

class EspecieAnimalCubit extends Cubit<EspeciesAnimalesState> {
  final EspecieAnimalUsecaseDB especieAnimalUsecaseDB;

  EspecieAnimalCubit({required this.especieAnimalUsecaseDB})
      : super(EspeciesAnimalesInitial());

  void getEspeciesAnimalesDB() async {
    final result = await especieAnimalUsecaseDB.getEspeciesAnimalesUsecaseDB();
    result.fold(
        (failure) => emit(EspeciesAnimalesError(failure.properties.first)),
        (data) => emit(EspeciesAnimalesLoaded(data)));
  }

  Future<List<LstAnimalCria>> getUbicacionEspeciesAnimalesDB(
      int? ubicacionId) async {
    final result = await especieAnimalUsecaseDB
        .getUbicacionEspeciesAnimalesUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
