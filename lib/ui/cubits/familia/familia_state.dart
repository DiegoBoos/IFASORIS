import 'package:flutter_bloc/flutter_bloc.dart';

import 'familia_cubit.dart';

class FamiliaCubit extends Cubit<FamiliaState> {
  FamiliaCubit() : super(FamiliaInitial());

  void initState() => emit(FamiliaInitial());

  /* void saveFamiliaDB(FamiliaEntity familiaEntity) async {
    final result = await familiaUsecaseDB
        .saveFamiliaUsecaseDB(familiaEntity);
    result.fold((failure) => emit(FamiliaError(failure.properties.first)),
        (data) => emit(FamiliaSaved(familia: familiaEntity)));
  }

  Future<void> getFamilia(String familiaId) async {
    final result =
        await familiaUsecaseDB.getFamiliaUsecaseDB(familiaId);
    result.fold((failure) => emit(FamiliaError(failure.properties.first)),
        (data) {
      if (data == null) {
        emit(FamiliaError('No se encontró el familia'));
      } else {
        emit(FamiliaLoaded(data));
      }
    });
  } */

  void changeFichaId(int value) {
    final fichaIdChanged = state.familia.copyWith(fichaId: value);
    emit(FamiliaChanged(fichaIdChanged));
  }

  void changeApellidosFlia(String value) {
    final apellidosFliaChanged = state.familia.copyWith(apellidosFlia: value);
    emit(FamiliaChanged(apellidosFliaChanged));
  }

  void changeAfiliadoId(int value) {
    final afiliadoIdChanged = state.familia.copyWith(afiliadoId: value);
    emit(FamiliaChanged(afiliadoIdChanged));
  }
}
