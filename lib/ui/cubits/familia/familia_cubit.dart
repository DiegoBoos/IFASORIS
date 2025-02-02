import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/familia/familia_db_usecase.dart';

import '../../../domain/entities/familia.dart';
part 'familia_state.dart';

class FamiliaCubit extends Cubit<FamiliaState> {
  final FamiliaUsecaseDB familiaUsecaseDB;
  FamiliaCubit({required this.familiaUsecaseDB}) : super(FamiliaInitial());

  void initState() => emit(FamiliaInitial());

  createFamiliaDB(FamiliaEntity familia) async {
    final result = await familiaUsecaseDB.createFamiliaUsecaseDB(familia);
    result.fold((failure) => emit(FamiliaError(failure.properties.first)),
        (data) {
      if (data == null) {
        emit(FamiliaError('Error al crear la familia'));
      } else {
        emit(FamiliaCreated(data));
      }
    });
  }

  deleteAfiliadoFamilia(int fkAfiliadoId) async {
    final result =
        await familiaUsecaseDB.deleteAfiliadoFamiliaUsecaseDB(fkAfiliadoId);
    result.fold((failure) => emit(FamiliaError(failure.properties.first)),
        (data) => emit(FamiliaEliminada(data)));
  }
}
