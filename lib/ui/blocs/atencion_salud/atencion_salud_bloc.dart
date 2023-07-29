import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/data/models/enfermedad_tradicional_model.dart';
import 'package:ifasoris/data/models/especialidad_med_tradicional_model.dart';

import '../../../data/models/lugar_atencion_medico_model.dart';
import '../../../data/models/planta_medicinal_model.dart';
import '../../../domain/entities/atencion_salud_entity.dart';
import '../../../domain/usecases/atencion_salud/atencion_salud_db_usecase.dart';

part 'atencion_salud_event.dart';
part 'atencion_salud_state.dart';

class AtencionSaludBloc extends Bloc<AtencionSaludEvent, AtencionSaludEntity> {
  final AtencionSaludUsecaseDB atencionSaludUsecaseDB;

  AtencionSaludBloc({required this.atencionSaludUsecaseDB})
      : super(initObject()) {
    on<AtencionSaludInit>((event, emit) {
      emit(initObject());
    });

    on<AtencionSaludSubmitted>((event, emit) async {
      final result = await atencionSaludUsecaseDB
          .saveAtencionSaludUsecaseDB(event.atencionSalud);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                AtencionSaludSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(formStatus: AtencionSaludSubmissionSuccess()));
      });
    });

    on<GetAtencionSalud>((event, emit) async {
      final result = await atencionSaludUsecaseDB
          .getAtencionSaludUsecaseDB(event.afiliadoId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                AtencionSaludSubmissionFailed(failure.properties.first)));
      }, (data) {
        if (data != null) {
          emit(data.copyWith(formStatus: AtencionSaludFormLoaded()));
        } else {
          emit(state.copyWith(formStatus: AtencionSaludFormEmpty()));
        }
      });
    });

    on<AtencionSaludChanged>((event, emit) {
      emit(state.copyWith(atencionSaludId: event.atencionSaludId));
    });
    on<AfiliadoChanged>((event, emit) {
      emit(state.copyWith(atencionSaludId: event.afiliadoId));
    });
    on<FamiliaChanged>((event, emit) {
      emit(state.copyWith(atencionSaludId: event.familiaId));
    });
    on<EnfermedadAcudeChanged>((event, emit) {
      emit(state.copyWith(atencionSaludId: event.enfermedadAcudeId));
    });
    on<EnfermedadTratamientoChanged>((event, emit) {
      emit(state.copyWith(atencionSaludId: event.enfermedadTratamientoId));
    });
    on<EnfermedadTradicionalChanged>((event, emit) {
      emit(state.copyWith(atencionSaludId: event.enfermedadTradicionalId));
    });
    on<PlantaMedicinalChanged>((event, emit) {
      emit(state.copyWith(atencionSaludId: event.plantaMedicinalId));
    });
    on<UtilizaMetodoPlanificacionChanged>((event, emit) {
      emit(state.copyWith(atencionSaludId: event.utilizaMetodoPlanificacionId));
    });
    on<EnfermedadesTradicionalesChanged>((event, emit) {
      emit(state.copyWith(
          lstEnfermedadesTradicionales: event.lstEnfermedadesTradicionales));
    });
    on<EspecialidadesMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(
          lstEspecialidadesMedTradicional:
              event.lstEspecialidadesMedTradicional));
    });
    on<LugaresAtencionMedicoChanged>((event, emit) {
      emit(state.copyWith(
          lstLugaresAtencionMedico: event.lstLugaresAtencionMedico));
    });
    on<PlantasMedicinalesChanged>((event, emit) {
      emit(state.copyWith(lstPlantasMedicinales: event.lstPlantasMedicinales));
    });
  }
}
