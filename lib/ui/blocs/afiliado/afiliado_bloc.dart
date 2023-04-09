import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/afiliado/afiliado_db_usecase.dart';

import '../../../domain/entities/afiliado_entity.dart';

part 'afiliado_event.dart';
part 'afiliado_state.dart';

class AfiliadoBloc extends Bloc<AfiliadosEvent, AfiliadosState> {
  final AfiliadoUsecaseDB afiliadoUsecaseDB;
  AfiliadoBloc({required this.afiliadoUsecaseDB}) : super(AfiliadosInitial()) {
    on<GetAfiliadosByDepartamento>((event, emit) async {
      emit(AfiliadosLoading());
      await _getAfiliadosByDepartamento(event, emit);
    });
  }

  _getAfiliadosByDepartamento(
      GetAfiliadosByDepartamento event, Emitter<AfiliadosState> emit) async {
    final dtoId = event.dtoId;
    final pagina = event.pagina;
    final registrosPorPagina = event.registrosPorPagina;

    final result = await afiliadoUsecaseDB.getAfiliadosUsecaseDB(
        dtoId, pagina, registrosPorPagina);

    result.fold((failure) => emit(AfiliadosError(failure.properties.first)),
        (data) => emit(AfiliadosLoaded(afiliadosLoaded: data)));
  }
}
