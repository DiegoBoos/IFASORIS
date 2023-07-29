import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/sancion_justicia_entity.dart';
import '../../../domain/usecases/sancion_justicia/sancion_justicia_db_usecase.dart';

part 'sancion_justicia_state.dart';

class SancionJusticiaCubit extends Cubit<SancionesJusticiaState> {
  final SancionJusticiaUsecaseDB sancionJusticiaUsecaseDB;

  SancionJusticiaCubit({required this.sancionJusticiaUsecaseDB})
      : super(SancionesJusticiaInitial());

  void getSancionJusticiaDB() async {
    final result =
        await sancionJusticiaUsecaseDB.getSancionesJusticiaUsecaseDB();
    result.fold(
        (failure) => emit(SancionesJusticiaError(failure.properties.first)),
        (data) => emit(SancionesJusticiaLoaded(data)));
  }
}
