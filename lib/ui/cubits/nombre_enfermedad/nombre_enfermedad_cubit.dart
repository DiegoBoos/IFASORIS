import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/nombre_enfermedad_model.dart';
import '../../../domain/entities/nombre_enfermedad_entity.dart';
import '../../../domain/usecases/nombre_enfermedad/nombre_enfermedad_db_usecase.dart';

part 'nombre_enfermedad_state.dart';

class NombreEnfermedadCubit extends Cubit<NombresEnfermedadesState> {
  final NombreEnfermedadUsecaseDB nombreEnfermedadUsecaseDB;

  NombreEnfermedadCubit({required this.nombreEnfermedadUsecaseDB})
      : super(NombresEnfermedadesInitial());

  void getNombreEnfermedadDB() async {
    final result =
        await nombreEnfermedadUsecaseDB.getNombresEnfermedadesUsecaseDB();
    result.fold(
        (failure) => emit(NombresEnfermedadesError(failure.properties.first)),
        (data) => emit(NombresEnfermedadesLoaded(data)));
  }

  Future<List<LstNombreEnfermedad>> getNombresEnfermedadesDB(
      int? cuidadoSaludCondRiesgoId) async {
    final result = await nombreEnfermedadUsecaseDB
        .getLstNombresEnfermedadesUsecaseDB(cuidadoSaludCondRiesgoId);
    return result.fold((failure) => [], (data) => data);
  }
}
