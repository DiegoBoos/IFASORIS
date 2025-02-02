import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/medio_comunicacion/medio_comunicacion_db_usecase.dart';

import '../../../data/models/medio_comunicacion.dart';
import '../../../domain/entities/medio_comunicacion.dart';

part 'medio_comunicacion_state.dart';

class MedioComunicacionCubit extends Cubit<MediosComunicacionState> {
  final MedioComunicacionUsecaseDB medioComunicacionUsecaseDB;
  MedioComunicacionCubit({required this.medioComunicacionUsecaseDB})
      : super(MediosComunicacionInitial());

  void getMediosComunicacionDB() async {
    final result =
        await medioComunicacionUsecaseDB.getMediosComunicacionUsecase();
    result.fold(
        (failure) => emit(MediosComunicacionError(failure.properties.first)),
        (data) => emit(MediosComunicacionLoaded(data)));
  }

  Future<List<LstMediosComunica>> getUbicacionMediosComunicacionDB(
      int? ubicacionId) async {
    final result = await medioComunicacionUsecaseDB
        .getUbicacionMediosComunicacionUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
