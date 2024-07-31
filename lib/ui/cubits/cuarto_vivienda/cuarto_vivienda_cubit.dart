import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/cuarto_vivienda.dart';
import '../../../domain/usecases/cuarto_vivienda/cuarto_vivienda_db_usecase.dart';

part 'cuarto_vivienda_state.dart';

class CuartoViviendaCubit extends Cubit<CuartosViviendaState> {
  final CuartoViviendaUsecaseDB cuartoViviendaUsecaseDB;

  CuartoViviendaCubit({required this.cuartoViviendaUsecaseDB})
      : super(CuartosViviendaInitial());

  void getCuartosViviendaDB() async {
    final result = await cuartoViviendaUsecaseDB.getCuartosViviendaUsecaseDB();
    result.fold(
        (failure) => emit(CuartosViviendaError(failure.properties.first)),
        (data) => emit(CuartosViviendaLoaded(data)));
  }
}
