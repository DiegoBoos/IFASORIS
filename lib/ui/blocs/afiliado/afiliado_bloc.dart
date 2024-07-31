import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/afiliado/afiliado_db_usecase.dart';

import '../../../domain/entities/afiliado.dart';
import '../../../domain/entities/ficha.dart';

part 'afiliado_event.dart';
part 'afiliado_state.dart';

class AfiliadoBloc extends Bloc<AfiliadosEvent, AfiliadosState> {
  final AfiliadoUsecaseDB afiliadoUsecaseDB;
  AfiliadoBloc({required this.afiliadoUsecaseDB}) : super(AfiliadosInitial()) {
    on<QueryChanged>((event, emit) async {
      emit(AfiliadosLoading());
      await _searchAfiliados(event, emit);
    });
    on<ErrorMessage>((event, emit) async {
      emit(AfiliadosError(event.message));
    });
  }

  _searchAfiliados(QueryChanged event, Emitter<AfiliadosState> emit) async {
    final result = await afiliadoUsecaseDB.getAfiliadosUsecaseDB(event.query);

    result.fold((failure) => emit(AfiliadosError(failure.properties.first)),
        (data) => emit(AfiliadosLoaded(afiliadosLoaded: data)));
  }

  Future<FichaEntity?> afiliadoTieneFicha(int afiliadoId) async {
    final result =
        await afiliadoUsecaseDB.afiliadoTieneFichaRepositoryDB(afiliadoId);

    return result.fold((failure) => null, (data) => data);
  }

  Future<String> afiliadoTieneFichaReportada(int afiliadoId) async {
    final result = await afiliadoUsecaseDB
        .afiliadoTieneFichaReportadaRepositoryDB(afiliadoId);

    return result.fold((failure) => '0', (data) => data);
  }
}
