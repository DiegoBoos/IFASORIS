import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/techo_vivienda.dart';

import '../../../domain/entities/techo_vivienda.dart';
import '../../../domain/usecases/techo_vivienda/techo_vivienda_db_usecase.dart';

part 'techo_vivienda_state.dart';

class TechoViviendaCubit extends Cubit<TechosViviendaState> {
  final TechoViviendaUsecaseDB techoViviendaUsecaseDB;

  TechoViviendaCubit({required this.techoViviendaUsecaseDB})
      : super(TechosViviendaInitial());

  void getTechosViviendaDB() async {
    final result = await techoViviendaUsecaseDB.getTechosViviendaUsecaseDB();
    result.fold(
        (failure) => emit(TechosViviendaError(failure.properties.first)),
        (data) => emit(TechosViviendaLoaded(data)));
  }

  Future<List<LstTecho>> getTechosViviendaViviendaDB(
      int? datoViviendaId) async {
    final result = await techoViviendaUsecaseDB
        .getTechosViviendaViviendaUsecaseDB(datoViviendaId);
    return result.fold((failure) => [], (data) => data);
  }
}
