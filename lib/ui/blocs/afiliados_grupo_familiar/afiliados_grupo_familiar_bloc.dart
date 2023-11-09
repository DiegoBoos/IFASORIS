import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../domain/usecases/grupo_familiar/grupo_familiar_db_usecase.dart';

part 'afiliados_grupo_familiar_event.dart';
part 'afiliados_grupo_familiar_state.dart';

class AfiliadosGrupoFamiliarBloc
    extends Bloc<AfiliadosGrupoFamiliarEvent, AfiliadosGrupoFamiliarState> {
  final GrupoFamiliarUsecaseDB grupoFamiliarUsecaseDB;

  AfiliadosGrupoFamiliarBloc({required this.grupoFamiliarUsecaseDB})
      : super(AfiliadosGrupoFamiliarInitial()) {
    on<ExisteAfiliadoCabezaFamilia>((event, emit) async {
      emit(AfiliadosGrupoFamiliarLoading());
      final result = await grupoFamiliarUsecaseDB
          .existeAfiliadoCabezaFamiliaUsecaseDB(event.familiaId);
      result.fold((failure) {
        emit(const AfiliadosGrupoFamiliarError(
          'Excepción no controlada',
        ));
      }, (data) => emit(AfiliadoCabezaFamiliaLoaded(data)));
    });

    on<GetAfiliadosGrupoFamiliar>((event, emit) async {
      emit(AfiliadosGrupoFamiliarLoading());
      final result = await grupoFamiliarUsecaseDB
          .getGrupoFamiliarUsecaseDB(event.familiaId);
      result.fold((failure) {
        emit(const AfiliadosGrupoFamiliarError(
          'Excepción no controlada',
        ));
      }, (data) {
        if (data.isNotEmpty) {
          emit(
              AfiliadosGrupoFamiliarLoaded(afiliadosGrupoFamiliarLoaded: data));
        } else {
          emit(AfiliadosGrupoFamiliarInitial());
        }
      });
    });

    on<ErrorAfiliadosGrupoFamiliar>((event, emit) {
      emit(AfiliadosGrupoFamiliarError(event.message));
    });
  }
}
