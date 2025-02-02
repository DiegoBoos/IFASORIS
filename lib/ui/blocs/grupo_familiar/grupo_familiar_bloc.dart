import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/afiliado.dart';
import '../../../domain/entities/grupo_familiar.dart';
import '../../../domain/usecases/afiliado/afiliado_db_usecase.dart';
import '../../../domain/usecases/grupo_familiar/grupo_familiar_db_usecase.dart';

part 'grupo_familiar_event.dart';
part 'grupo_familiar_state.dart';

class GrupoFamiliarBloc extends Bloc<GrupoFamiliarEvent, GrupoFamiliarEntity> {
  final GrupoFamiliarUsecaseDB grupoFamiliarUsecaseDB;
  final AfiliadoUsecaseDB afiliadoUsecaseDB;

  GrupoFamiliarBloc(
      {required this.grupoFamiliarUsecaseDB, required this.afiliadoUsecaseDB})
      : super(initObject()) {
    on<GrupoFamiliarInit>((event, emit) {
      emit(initObject());
    });

    on<CheckFichaAfiliado>((event, emit) async {
      final result = await afiliadoUsecaseDB
          .afiliadoTieneFichaRepositoryDB(event.afiliado.afiliadoId!);

      result.fold(
          (failure) => emit(state.copyWith(
              formStatus: GrupoFamiliarError(failure.properties.first))),
          (data) {
        if (data == null) {
          emit(state.copyWith(
              formStatus: GrupoFamiliarError(
                  'Esta persona ya se encuentra dentro de la ficha de un núcleo familiar')));
        } else {
          final newGrupoFamiliar = GrupoFamiliarEntity(
            afiliadoId: event.afiliado.afiliadoId,
            documento: event.afiliado.documento,
            edad: event.afiliado.edad,
            fechaNacimiento: event.afiliado.fecnac,
            nombre1: event.afiliado.nombre1,
            nombre2: event.afiliado.nombre2,
            apellido1: event.afiliado.apellido1,
            apellido2: event.afiliado.apellido2,
            tipoDocAfiliado: event.afiliado.tipoDocAfiliado,
            codGeneroAfiliado: event.afiliado.codGeneroAfiliado,
            codRegimenAfiliado: event.afiliado.codRegimenAfiliado,
          );
          emit(
            newGrupoFamiliar.copyWith(
              formStatus: NuevoGrupoFamiliar(),
            ),
          );
        }
      });
    });

    on<SaveAfiliadoGrupoFamiliar>((event, emit) async {
      emit(state.copyWith(formStatus: GrupoFamiliarFormLoading()));
      final result = await grupoFamiliarUsecaseDB
          .saveAfiliadoGrupoFamiliarUsecaseDB(event.grupoFamiliar);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: GrupoFamiliarError((failure.properties.first))));
      }, (data) {
        emit(data.copyWith(formStatus: GrupoFamiliarSubmissionSuccess()));
      });
    });

    on<CompleteGrupoFamiliar>(
        (event, emit) => _completeGrupoFamiliar(event, emit));

    on<ErrorGrupoFamiliar>((event, emit) {
      emit(state.copyWith(formStatus: GrupoFamiliarErrorAndPop(event.message)));
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
    on<OtroOcupacionChanged>((event, emit) {
      emit(state.copyWith(otroOcupacion: event.otroOcupacion));
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

  _completeGrupoFamiliar(
      CompleteGrupoFamiliar event, Emitter<GrupoFamiliarEntity> emit) async {
    final result = await grupoFamiliarUsecaseDB
        .completeGrupoFamiliarUsecaseDB(event.afiliadoId);

    result.fold(
        (failure) => emit(state.copyWith(
            formStatus: GrupoFamiliarError(failure.properties.first))),
        (data) => emit(state.copyWith(formStatus: GrupoFamiliarCompleted())));
  }
}
