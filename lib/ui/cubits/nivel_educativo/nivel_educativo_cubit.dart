import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/nivel_educativo/nivel_educativo_exports.dart';

part 'nivel_educativo_state.dart';

class NivelEducativoCubit extends Cubit<NivelesEducativosState> {
  final NivelEducativoUsecaseDB nivelEducativoUsecaseDB;

  NivelEducativoCubit({required this.nivelEducativoUsecaseDB})
      : super(NivelesEducativosInitial());

  void getNivelesEducativosDB() async {
    final result = await nivelEducativoUsecaseDB.getNivelesEducativosUsecase();
    result.fold(
        (failure) => emit(NivelesEducativosError(failure.properties.first)),
        (data) => emit(NivelesEducativosLoaded(data)));
  }
}
