import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/nro_cuarto_vivienda.dart';
import '../../../domain/usecases/nro_cuarto_vivienda/nro_cuarto_vivienda_db_usecase.dart';

part 'nro_cuarto_vivienda_state.dart';

class NroCuartoViviendaCubit extends Cubit<NroCuartosViviendaState> {
  final NroCuartoViviendaUsecaseDB nroCuartoViviendaUsecaseDB;

  NroCuartoViviendaCubit({required this.nroCuartoViviendaUsecaseDB})
      : super(NroCuartosViviendaInitial());

  void getNroCuartosViviendaDB() async {
    final result =
        await nroCuartoViviendaUsecaseDB.getNroCuartosViviendaUsecaseDB();
    result.fold(
        (failure) => emit(NroCuartosViviendaError(failure.properties.first)),
        (data) => emit(NroCuartosViviendaLoaded(data)));
  }
}
