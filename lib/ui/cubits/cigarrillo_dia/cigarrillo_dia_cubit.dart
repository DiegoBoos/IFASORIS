import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cigarrillo_dia.dart';
import '../../../domain/usecases/cigarrillo_dia/cigarrillo_dia_db_usecase.dart';

part 'cigarrillo_dia_state.dart';

class CigarrilloDiaCubit extends Cubit<CigarrillosDiaState> {
  final CigarrilloDiaUsecaseDB cigarrilloDiaUsecaseDB;

  CigarrilloDiaCubit({required this.cigarrilloDiaUsecaseDB})
      : super(CigarrillosDiaInitial());

  void getCigarrilloDiaDB() async {
    final result = await cigarrilloDiaUsecaseDB.getCigarrillosDiaUsecaseDB();
    result.fold(
        (failure) => emit(CigarrillosDiaError(failure.properties.first)),
        (data) => emit(CigarrillosDiaLoaded(data)));
  }
}
