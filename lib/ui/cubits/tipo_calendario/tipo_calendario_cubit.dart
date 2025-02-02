import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_calendario.dart';
import '../../../domain/usecases/tipo_calendario/tipo_calendario_db_usecase.dart';

part 'tipo_calendario_state.dart';

class TipoCalendarioCubit extends Cubit<TiposCalendarioState> {
  final TipoCalendarioUsecaseDB tipoCalendarioUsecaseDB;

  TipoCalendarioCubit({required this.tipoCalendarioUsecaseDB})
      : super(TiposCalendarioInitial());

  void getTiposCalendarioDB() async {
    final result = await tipoCalendarioUsecaseDB.getTiposCalendarioUsecaseDB();
    result.fold(
        (failure) => emit(TiposCalendarioError(failure.properties.first)),
        (data) => emit(TiposCalendarioLoaded(data)));
  }
}
