import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/cereal_model.dart';

import '../../../domain/entities/cereal_entity.dart';
import '../../../domain/usecases/cereal/cereal_db_usecase.dart';

part 'cereal_state.dart';

class CerealCubit extends Cubit<CerealesState> {
  final CerealUsecaseDB cerealUsecaseDB;

  CerealCubit({required this.cerealUsecaseDB}) : super(CerealesInitial());

  void getCerealesDB() async {
    final result = await cerealUsecaseDB.getCerealesUsecaseDB();
    result.fold((failure) => emit(CerealesError(failure.properties.first)),
        (data) => emit(CerealesLoaded(data)));
  }

  Future<List<LstCereal>> getUbicacionCerealesDB(int? ubicacionId) async {
    final result =
        await cerealUsecaseDB.getUbicacionCerealesUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
