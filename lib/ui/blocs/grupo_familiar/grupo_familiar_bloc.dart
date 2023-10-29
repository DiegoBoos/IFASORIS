import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../domain/usecases/grupo_familiar/grupo_familiar_db_usecase.dart';

part 'grupo_familiar_event.dart';
part 'grupo_familiar_state.dart';

class GrupoFamiliarBloc extends Bloc<GrupoFamiliarEvent, GrupoFamiliarEntity> {
  final GrupoFamiliarUsecaseDB grupoFamiliarUsecaseDB;

  GrupoFamiliarBloc({required this.grupoFamiliarUsecaseDB})
      : super(initObject()) {
    on<GrupoFamiliarInit>((event, emit) {
      emit(initObject());
    });

    on<SaveAfiliadoGrupoFamiliar>((event, emit) async {
      final result = await grupoFamiliarUsecaseDB
          .saveAfiliadoGrupoFamiliarUsecaseDB(event.grupoFamiliar);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                GrupoFamiliarSubmissionFailed((failure.properties.first))));
      }, (data) {
        emit(state.copyWith(formStatus: GrupoFamiliarSubmissionSuccess()));
      });
    });

    on<FamiliaChanged>((event, emit) {
      emit(state.copyWith(familiaId: event.familiaId));
    });

    on<CursoVidaChanged>((event, emit) {
      emit(state.copyWith(cursoVidaId: event.cursoVidaId));
    });
    on<ParentescoChanged>((event, emit) {
      emit(state.copyWith(parentescoId: event.parentescoId));
    });
    on<TipoRegimenChanged>((event, emit) {
      emit(state.copyWith(tipoRegimenId: event.tipoRegimenId));
    });
    on<NivelEducativoChanged>((event, emit) {
      emit(state.copyWith(nivelEducativoId: event.nivelEducativoId));
    });
    on<OcupacionChanged>((event, emit) {
      emit(state.copyWith(ocupacionId: event.ocupacionId));
    });
    on<GrupoRiesgoChanged>((event, emit) {
      emit(state.copyWith(grupoRiesgoId: event.grupoRiesgoId));
    });
    on<EtniaChanged>((event, emit) {
      emit(state.copyWith(
          origenEtnico5602Id: event.origenEtnico5602Id,
          etniaId: event.origenEtnico5602Id));
    });
    on<PuebloIndigenaChanged>((event, emit) {
      emit(state.copyWith(puebloIndigenaId: event.puebloIndigenaId));
    });
    on<LenguaManejaChanged>((event, emit) {
      emit(state.copyWith(lenguaManejaId: event.lenguaManejaId));
    });
    on<LenguaMaternaChanged>((event, emit) {
      emit(state.copyWith(lenguaMaternaId: event.lenguaMaternaId));
    });
  }

  Future<int> deleteAfiliadoGrupoFamiliar(
    int afiliadoId,
    int familiaId,
  ) async {
    final result = await grupoFamiliarUsecaseDB
        .deleteAfiliadoGrupoFamiliarUsecaseDB(afiliadoId, familiaId);
    return result.fold((failure) => 0, (data) => data);
  }

  Future<int> completeGrupoFamiliar(int familiaId) async {
    final result =
        await grupoFamiliarUsecaseDB.completeGrupoFamiliarUsecaseDB(familiaId);

    return result.fold((failure) => 0, (data) => data);
  }
}
