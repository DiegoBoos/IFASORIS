import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/leguminosa_entity.dart';
import '../../../domain/usecases/leguminosa_by_dpto/leguminosa_by_dpto_db_usecase.dart';

part 'leguminosa_by_dpto_state.dart';

class LeguminosaByDptoCubit extends Cubit<LeguminosasByDptoState> {
  final LeguminosaByDptoUsecaseDB leguminosaByDptoUsecaseDB;

  LeguminosaByDptoCubit({required this.leguminosaByDptoUsecaseDB})
      : super(LeguminosasByDptoInitial()) {
    getLeguminosasByDptoDB();
  }

  void getLeguminosasByDptoDB() async {
    final result =
        await leguminosaByDptoUsecaseDB.getLeguminosasByDptoUsecaseDB();
    result.fold(
        (failure) => emit(LeguminosasByDptoError(failure.properties.first)),
        (data) => emit(LeguminosasByDptoLoaded(data)));
  }
}
