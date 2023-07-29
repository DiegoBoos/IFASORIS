import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/ultima_vez_inst_salud_entity.dart';
import '../../../domain/usecases/ultima_vez_inst_salud/ultima_vez_inst_salud_db_usecase.dart';

part 'ultima_vez_inst_salud_state.dart';

class UltimaVezInstSaludCubit extends Cubit<UltimasVecesInstSaludState> {
  final UltimaVezInstSaludUsecaseDB ultimaVezInstSaludUsecaseDB;

  UltimaVezInstSaludCubit({required this.ultimaVezInstSaludUsecaseDB})
      : super(UltimasVecesInstSaludInitial());

  void getUltimaVezInstSaludDB() async {
    final result =
        await ultimaVezInstSaludUsecaseDB.getUltimasVecesInstSaludUsecaseDB();
    result.fold(
        (failure) => emit(UltimasVecesInstSaludError(failure.properties.first)),
        (data) => emit(UltimasVecesInstSaludLoaded(data)));
  }
}
