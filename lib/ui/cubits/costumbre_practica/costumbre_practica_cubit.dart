import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/costumbre_practica_entity.dart';
import '../../../domain/usecases/costumbre_practica/costumbre_practica_db_usecase.dart';

part 'costumbre_practica_state.dart';

class CostumbrePracticaCubit extends Cubit<CostumbresPracticanState> {
  final CostumbrePracticaUsecaseDB costumbrePracticaUsecaseDB;

  CostumbrePracticaCubit({required this.costumbrePracticaUsecaseDB})
      : super(CostumbresPracticanInitial());

  void getCostumbrePracticaDB() async {
    final result =
        await costumbrePracticaUsecaseDB.getCostumbresPracticanUsecaseDB();
    result.fold(
        (failure) => emit(CostumbresPracticanError(failure.properties.first)),
        (data) => emit(CostumbresPracticanLoaded(data)));
  }
}
