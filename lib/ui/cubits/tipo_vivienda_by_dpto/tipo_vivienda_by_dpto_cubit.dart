import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_vivienda_entity.dart';
import '../../../domain/usecases/tipo_vivienda_by_dpto/tipo_vivienda_by_dpto_db_usecase.dart';

part 'tipo_vivienda_by_dpto_state.dart';

class TipoViviendaByDptoCubit extends Cubit<TiposViviendaByDptoState> {
  final TipoViviendaByDptoUsecaseDB tipoViviendaByDptoUsecaseDB;

  TipoViviendaByDptoCubit({required this.tipoViviendaByDptoUsecaseDB})
      : super(TiposViviendaByDptoInitial());

  void getTiposViviendaByDptoDB() async {
    final result =
        await tipoViviendaByDptoUsecaseDB.getTiposViviendaByDptoUsecaseDB();
    result.fold(
        (failure) => emit(TiposViviendaByDptoError(failure.properties.first)),
        (data) => emit(TiposViviendaByDptoLoaded(data)));
  }
}
