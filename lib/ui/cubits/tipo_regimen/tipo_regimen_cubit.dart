import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_regimen.dart';
import '../../../domain/usecases/tipo_regimen/tipo_regimen_db_usecase.dart';
part '../tipo_regimen/tipo_regimen_state.dart';

class TipoRegimenCubit extends Cubit<TipoRegimenesState> {
  final TipoRegimenUsecaseDB tipoRegimenUsecaseDB;

  TipoRegimenCubit({required this.tipoRegimenUsecaseDB})
      : super(TipoRegimenesInitial());

  void getTipoRegimenesDB() async {
    final result = await tipoRegimenUsecaseDB.getTipoRegimenesUsecaseDB();
    result.fold((failure) => emit(TipoRegimenesError(failure.properties.first)),
        (data) => emit(TipoRegimenesLoaded(data)));
  }
}
