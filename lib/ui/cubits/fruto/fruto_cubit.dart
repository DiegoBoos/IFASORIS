import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/fruto_model.dart';

import '../../../domain/entities/fruto_entity.dart';
import '../../../domain/usecases/fruto/fruto_db_usecase.dart';

part 'fruto_state.dart';

class FrutoCubit extends Cubit<FrutosState> {
  final FrutoUsecaseDB frutoUsecaseDB;

  FrutoCubit({required this.frutoUsecaseDB}) : super(FrutosInitial());

  void getFrutosDB() async {
    final result = await frutoUsecaseDB.getFrutosUsecaseDB();
    result.fold((failure) => emit(FrutosError(failure.properties.first)),
        (data) => emit(FrutosLoaded(data)));
  }

  Future<List<LstFruto>> getUbicacionFrutosDB(int? ubicacionId) async {
    final result =
        await frutoUsecaseDB.getUbicacionFrutosUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
