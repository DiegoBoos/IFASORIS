import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/curso_vida/curso_vida_exports.dart';

part 'curso_vida_state.dart';

class CursoVidaCubit extends Cubit<CursosVidaState> {
  final CursoVidaUsecaseDB cursoVidaUsecaseDB;

  CursoVidaCubit({required this.cursoVidaUsecaseDB})
      : super(CursosVidaInitial());

  void getCursosVidaDB() async {
    final result = await cursoVidaUsecaseDB.getCursosVidaUsecase();
    result.fold((failure) => emit(CursosVidaError(failure.properties.first)),
        (data) => emit(CursosVidaLoaded(data)));
  }
}
