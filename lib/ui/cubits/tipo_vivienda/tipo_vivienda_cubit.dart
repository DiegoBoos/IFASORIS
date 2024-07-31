import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_vivienda.dart';
import '../../../domain/usecases/tipo_vivienda/tipo_vivienda_db_usecase.dart';

part 'tipo_vivienda_state.dart';

class TipoViviendaCubit extends Cubit<TiposViviendaState> {
  final TipoViviendaUsecaseDB tipoViviendaUsecaseDB;

  TipoViviendaCubit({required this.tipoViviendaUsecaseDB})
      : super(TiposViviendaInitial());

  void getTiposViviendaDB() async {
    final result = await tipoViviendaUsecaseDB.getTiposViviendaUsecaseDB();
    result.fold((failure) => emit(TiposViviendaError(failure.properties.first)),
        (data) => emit(TiposViviendaLoaded(data)));
  }
}
