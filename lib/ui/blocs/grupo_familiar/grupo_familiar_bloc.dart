import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';

part 'grupo_familiar_event.dart';
part 'grupo_familiar_state.dart';

class GrupoFamiliarBloc extends Bloc<GrupoFamiliarEvent, GrupoFamiliarEntity> {
  /* final GrupoFamiliarUsecaseDB grupoFamiliarUsecaseDB; */

  GrupoFamiliarBloc() : super(GrupoFamiliarEntity()) {
    on<GrupoFamiliarInit>((event, emit) {
      emit(GrupoFamiliarEntity());
    });

    /*  on<GrupoFamiliarSubmitted>((event, emit) async {
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
    }); */

    on<IsCompletedChanged>((event, emit) {
      emit(state.copyWith(isCompleted: event.isCompleted));
    });
  }
}
