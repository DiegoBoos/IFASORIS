import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/tuberculo_platano_model.dart';

import '../../../domain/entities/tuberculo_platano_entity.dart';
import '../../../domain/usecases/tuberculo_platano/tuberculo_platano_db_usecase.dart';

part 'tuberculo_platano_state.dart';

class TuberculoPlatanoCubit extends Cubit<TuberculosPlatanosState> {
  final TuberculoPlatanoUsecaseDB tuberculoPlatanoUsecaseDB;

  TuberculoPlatanoCubit({required this.tuberculoPlatanoUsecaseDB})
      : super(TuberculosPlatanosInitial());

  void getTuberculosPlatanosDB() async {
    final result =
        await tuberculoPlatanoUsecaseDB.getTuberculosPlatanosUsecaseDB();
    result.fold(
        (failure) => emit(TuberculosPlatanosError(failure.properties.first)),
        (data) => emit(TuberculosPlatanosLoaded(data)));
  }

  Future<List<LstTuberculo>> getUbicacionTuberculosPlatanosDB(
      int? ubicacionId) async {
    final result = await tuberculoPlatanoUsecaseDB
        .getUbicacionTuberculosPlatanosUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
