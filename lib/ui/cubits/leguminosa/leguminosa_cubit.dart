import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/leguminosa.dart';

import '../../../domain/entities/leguminosa.dart';
import '../../../domain/usecases/leguminosa/leguminosa_db_usecase.dart';

part 'leguminosa_state.dart';

class LeguminosaCubit extends Cubit<LeguminosasState> {
  final LeguminosaUsecaseDB leguminosaUsecaseDB;

  LeguminosaCubit({required this.leguminosaUsecaseDB})
      : super(LeguminosasInitial());

  void getLeguminosasDB() async {
    final result = await leguminosaUsecaseDB.getLeguminosasUsecaseDB();
    result.fold((failure) => emit(LeguminosasError(failure.properties.first)),
        (data) => emit(LeguminosasLoaded(data)));
  }

  Future<List<LstLeguminosa>> getUbicacionLeguminosasDB(
      int? ubicacionId) async {
    final result =
        await leguminosaUsecaseDB.getUbicacionLeguminosasUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
