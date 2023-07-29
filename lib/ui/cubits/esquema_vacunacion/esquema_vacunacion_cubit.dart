import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/esquema_vacunacion_entity.dart';
import '../../../domain/usecases/esquema_vacunacion/esquema_vacunacion_db_usecase.dart';

part 'esquema_vacunacion_state.dart';

class EsquemaVacunacionCubit extends Cubit<EsquemasVacunacionState> {
  final EsquemaVacunacionUsecaseDB esquemaVacunacionUsecaseDB;

  EsquemaVacunacionCubit({required this.esquemaVacunacionUsecaseDB})
      : super(EsquemasVacunacionInitial());

  void getEsquemaVacunacionDB() async {
    final result =
        await esquemaVacunacionUsecaseDB.getEsquemasVacunacionUsecaseDB();
    result.fold(
        (failure) => emit(EsquemasVacunacionError(failure.properties.first)),
        (data) => emit(EsquemasVacunacionLoaded(data)));
  }
}
