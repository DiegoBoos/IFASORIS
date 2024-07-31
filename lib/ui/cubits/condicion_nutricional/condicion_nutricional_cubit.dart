import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/condicion_nutricional.dart';
import '../../../domain/usecases/condicion_nutricional/condicion_nutricional_db_usecase.dart';

part 'condicion_nutricional_state.dart';

class CondicionNutricionalCubit extends Cubit<CondicionesNutricionalesState> {
  final CondicionNutricionalUsecaseDB condicionNutricionalUsecaseDB;

  CondicionNutricionalCubit({required this.condicionNutricionalUsecaseDB})
      : super(CondicionesNutricionalesInitial());

  void getCondicionNutricionalDB() async {
    final result = await condicionNutricionalUsecaseDB
        .getCondicionesNutricionalesUsecaseDB();
    result.fold(
        (failure) =>
            emit(CondicionesNutricionalesError(failure.properties.first)),
        (data) => emit(CondicionesNutricionalesLoaded(data)));
  }
}
