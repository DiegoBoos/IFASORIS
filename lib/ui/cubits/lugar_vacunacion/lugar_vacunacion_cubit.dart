import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/lugar_vacunacion_entity.dart';
import '../../../domain/usecases/lugar_vacunacion/lugar_vacunacion_db_usecase.dart';

part 'lugar_vacunacion_state.dart';

class LugarVacunacionCubit extends Cubit<LugaresVacunacionState> {
  final LugarVacunacionUsecaseDB lugarVacunacionUsecaseDB;

  LugarVacunacionCubit({required this.lugarVacunacionUsecaseDB})
      : super(LugaresVacunacionInitial());

  void getLugarVacunacionDB() async {
    final result =
        await lugarVacunacionUsecaseDB.getLugaresVacunacionUsecaseDB();
    result.fold(
        (failure) => emit(LugaresVacunacionError(failure.properties.first)),
        (data) => emit(LugaresVacunacionLoaded(data)));
  }
}
