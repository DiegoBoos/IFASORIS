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

    on<GrupoFamiliarSubmitted>((event, emit) async {
      final result =
          await grupoFamiliarUsecaseDB.saveGrupoFamiliarUsecaseDB(state);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                GrupoFamiliarSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(formStatus: GrupoFamiliarSubmissionSuccess()));
      });
    });

    on<GetGrupoFamiliar>((event, emit) async {
      final result = await grupoFamiliarUsecaseDB
          .getGrupoFamiliarUsecaseDB(event.familiaId);
      result.fold(
          (failure) => emit(state.copyWith(
              formStatus:
                  GrupoFamiliarSubmissionFailed(failure.properties.first))),
          (data) {
        if (data != null) {
          emit(data.copyWith(formStatus: GrupoFamiliarFormLoaded()));
        } else {
          emit(state.copyWith(formStatus: GrupoFamiliarFormEmpty()));
        }
      });
    });

    on<IsCompletedChanged>((event, emit) {
      emit(state.copyWith(isCompleted: event.isCompleted));
    });
    on<FamiliaRegistroChanged>((event, emit) {
      emit(state.copyWith(familiaRegistroId: event.familiaRegistroId));
    });
    on<TipoDocumentoChanged>((event, emit) {
      emit(state.copyWith(tipoDocumentoId: event.tipoDocumentoId));
    });
    on<DocumentoChanged>((event, emit) {
      emit(state.copyWith(documento: event.documento));
    });
    on<NombresApellidosChanged>((event, emit) {
      emit(state.copyWith(nombresApellidos: event.nombresApellidos));
    });
    on<GeneroChanged>((event, emit) {
      emit(state.copyWith(generoId: event.generoId));
    });
    on<FechaNacChanged>((event, emit) {
      emit(state.copyWith(fechaNac: event.fechaNac));
    });
    on<EdadChanged>((event, emit) {
      emit(state.copyWith(edad: event.edad));
    });
    on<CursoVidaChanged>((event, emit) {
      emit(state.copyWith(cursoVida: event.cursoVida));
    });
    on<ParentescoChanged>((event, emit) {
      emit(state.copyWith(parentescoId: event.parentescoId));
    });
    on<RegimenChanged>((event, emit) {
      emit(state.copyWith(regimenId: event.regimenId));
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
      emit(state.copyWith(etniaId: event.etniaId));
    });
    on<PuebloIndigenaChanged>((event, emit) {
      emit(state.copyWith(puebloIndigenaId: event.puebloIndigenaId));
    });
    on<LenguaManejaChanged>((event, emit) {
      emit(state.copyWith(lenguaManejaId: event.lenguaManejaId));
    });
    on<NombreLenguaMaternaChanged>((event, emit) {
      emit(state.copyWith(nombreLenguaMaternaId: event.nombreLenguaMaternaId));
    });
  }
}
