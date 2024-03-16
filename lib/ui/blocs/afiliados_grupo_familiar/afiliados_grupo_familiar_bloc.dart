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

    on<AddAfiliadoGrupoFamiliar>((event, emit) async {
      emit(AfiliadosGrupoFamiliarLoaded(
          afiliadosGrupoFamiliarLoaded: [event.grupoFamiliar]));
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
        emit(AfiliadosGrupoFamiliarLoaded(afiliadosGrupoFamiliarLoaded: data));
      });
    });

    on<ErrorAfiliadosGrupoFamiliar>((event, emit) {
      emit(AfiliadosGrupoFamiliarError(event.message));
    });
  }
}
