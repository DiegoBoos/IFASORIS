import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/entities/medio_comunicacion_entity.dart';
import 'package:ifasoris/domain/usecases/medio_comunicacion/medio_comunicacion_db_usecase.dart';

part 'medio_comunicacion_state.dart';

class MedioComunicacionCubit extends Cubit<MediosComunicacionState> {
  final MedioComunicacionUsecaseDB medioComunicacionUsecaseDB;
  MedioComunicacionCubit({required this.medioComunicacionUsecaseDB})
      : super(MediosComunicacionInitial()) {
    getMediosComunicacionDB();
  }

  void getMediosComunicacionDB() async {
    final result =
        await medioComunicacionUsecaseDB.getMediosComunicacionUsecase();
    result.fold(
        (failure) => emit(MediosComunicacionError(failure.properties.first)),
        (data) => emit(MediosComunicacionLoaded(data)));
  }
}
