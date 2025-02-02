import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/hortaliza.dart';

import '../../../domain/entities/hortaliza.dart';
import '../../../domain/usecases/hortaliza/hortaliza_db_usecase.dart';

part 'hortaliza_state.dart';

class HortalizaCubit extends Cubit<HortalizasState> {
  final HortalizaUsecaseDB hortalizaUsecaseDB;

  HortalizaCubit({required this.hortalizaUsecaseDB})
      : super(HortalizasInitial());

  void getHortalizasDB() async {
    final result = await hortalizaUsecaseDB.getHortalizasUsecaseDB();
    result.fold((failure) => emit(HortalizasError(failure.properties.first)),
        (data) => emit(HortalizasLoaded(data)));
  }

  Future<List<LstHortaliza>> getUbicacionHortalizasDB(int? ubicacionId) async {
    final result =
        await hortalizaUsecaseDB.getUbicacionHortalizasUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
