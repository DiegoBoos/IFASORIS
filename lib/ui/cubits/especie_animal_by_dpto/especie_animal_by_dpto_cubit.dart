import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/especie_animal_entity.dart';
import '../../../domain/usecases/especie_animal_by_dpto/especie_animal_by_dpto_db_usecase.dart';

part 'especie_animal_by_dpto_state.dart';

class EspecieAnimalByDptoCubit extends Cubit<EspeciesAnimalesByDptoState> {
  final EspecieAnimalByDptoUsecaseDB especieanimalByDptoUsecaseDB;

  EspecieAnimalByDptoCubit({required this.especieanimalByDptoUsecaseDB})
      : super(EspeciesAnimalesByDptoInitial());

  void getEspeciesAnimalesByDptoDB() async {
    final result =
        await especieanimalByDptoUsecaseDB.getEspeciesAnimalesByDptoUsecaseDB();
    result.fold(
        (failure) =>
            emit(EspeciesAnimalesByDptoError(failure.properties.first)),
        (data) => emit(EspeciesAnimalesByDptoLoaded(data)));
  }
}
