import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/enfermedad_tradicional_model.dart';
import '../../../data/models/especialidad_med_tradicional_model.dart';
import '../../../data/models/lugar_atencion_medico_model.dart';
import '../../../data/models/planta_medicinal_model.dart';
import '../../../domain/entities/atencion_salud_entity.dart';
import '../../../domain/usecases/atencion_salud/atencion_salud_db_usecase.dart';
import '../../../domain/usecases/enfermedad_tradicional/enfermedad_tradicional_db_usecase.dart';
import '../../../domain/usecases/especialidad_med_tradicional/especialidad_med_tradicional_db_usecase.dart';
import '../../../domain/usecases/lugar_atencion_medico/lugar_atencion_medico_db_usecase.dart';
import '../../../domain/usecases/planta_medicinal/planta_medicinal_db_usecase.dart';

part 'atencion_salud_event.dart';
part 'atencion_salud_state.dart';

class AtencionSaludBloc extends Bloc<AtencionSaludEvent, AtencionSaludEntity> {
  final AtencionSaludUsecaseDB atencionSaludUsecaseDB;
  final EspecialidadMedTradicionalUsecaseDB especialidadMedTradicionalUsecaseDB;
  final EnfermedadTradicionalUsecaseDB enfermedadTradicionalUsecaseDB;
  final LugarAtencionMedicoUsecaseDB lugarAtencionMedicoUsecaseDB;
  final PlantaMedicinalUsecaseDB plantaMedicinalUsecaseDB;

  AtencionSaludBloc({
    required this.atencionSaludUsecaseDB,
    required this.especialidadMedTradicionalUsecaseDB,
    required this.enfermedadTradicionalUsecaseDB,
    required this.lugarAtencionMedicoUsecaseDB,
    required this.plantaMedicinalUsecaseDB,
  }) : super(initObject()) {
    on<AtencionSaludInit>((event, emit) {
      emit(initObject());
    });

    on<AtencionSaludSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: AtencionSaludFormLoading()));
      final result =
          await atencionSaludUsecaseDB.saveAtencionSaludUsecaseDB(state);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                AtencionSaludSubmissionFailed(failure.properties.first)));
      }, (data) async {
        await saveAtencionSaludEspecialidadMedTradicional(data);
      });
    });

    on<GetAtencionSalud>((event, emit) async {
      emit(state.copyWith(formStatus: AtencionSaludFormLoading()));
      final result = await atencionSaludUsecaseDB
          .getAtencionSaludUsecaseDB(event.afiliadoId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                AtencionSaludSubmissionFailed(failure.properties.first)));
      }, (data) {
        if (data != null) {
          emit(data);
          add(GetEspecialidadesMedTradicional(data.atencionSaludId));
        } else {
          emit(state.copyWith(formStatus: const AtencionSaludFormInitial()));
        }
      });
    });

    on<GetEspecialidadesMedTradicional>((event, emit) async {
      emit(state.copyWith(formStatus: AtencionSaludFormLoading()));
      final result = await especialidadMedTradicionalUsecaseDB
          .getEspecialidadesMedTradicionalAtencionSaludUsecaseDB(
              event.atencionSaludId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                AtencionSaludSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
          lstEspecialidadesMedTradicional: data,
        ));
        add(GetEnfermedadesTradicionales(event.atencionSaludId));
      });
    });

    on<GetEnfermedadesTradicionales>((event, emit) async {
      emit(state.copyWith(formStatus: AtencionSaludFormLoading()));
      final result = await enfermedadTradicionalUsecaseDB
          .getEnfermedadesTradicionalesAtencionSaludUsecaseDB(
              event.atencionSaludId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                AtencionSaludSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
          lstEnfermedadesTradicionales: data,
        ));
        add(GetLugaresAtencionMedico(event.atencionSaludId));
      });
    });

    on<GetLugaresAtencionMedico>((event, emit) async {
      emit(state.copyWith(formStatus: AtencionSaludFormLoading()));
      final result = await lugarAtencionMedicoUsecaseDB
          .getLugaresAtencionMedicoAtencionSaludUsecaseDB(
              event.atencionSaludId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                AtencionSaludSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
          lstLugaresAtencionMedico: data,
        ));
        add(GetPlantasMedicinales(event.atencionSaludId));
      });
    });

    on<GetPlantasMedicinales>((event, emit) async {
      emit(state.copyWith(formStatus: AtencionSaludFormLoading()));
      final result = await plantaMedicinalUsecaseDB
          .getPlantasMedicinalesAtencionSaludUsecaseDB(event.atencionSaludId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                AtencionSaludSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
            lstPlantasMedicinales: data,
            formStatus: AtencionSaludFormLoaded()));
      });
    });

    on<AtencionSaludFormSubmissionSuccess>((event, emit) {
      emit(state.copyWith(
        atencionSaludId: event.atencionSaludId,
        formStatus: AtencionSaludSubmissionSuccess(),
      ));
    });

    on<AtencionSaludChanged>((event, emit) {
      emit(state.copyWith(atencionSaludId: event.atencionSaludId));
    });
    on<AfiliadoChanged>((event, emit) {
      emit(state.copyWith(afiliadoId: event.afiliadoId));
    });
    on<FamiliaChanged>((event, emit) {
      emit(state.copyWith(familiaId: event.familiaId));
    });
    on<EnfermedadAcudeChanged>((event, emit) {
      emit(state.copyWith(enfermedadAcudeId: event.enfermedadAcudeId));
    });
    on<RecibioAtencionMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(
          recibioAtencionMedTradicionalId:
              event.recibioAtencionMedTradicionalId));
    });
    on<UtilizaPlantasMedChanged>((event, emit) {
      emit(state.copyWith(utilizaPlantasMedId: event.utilizaPlantasMedId));
    });
    on<LugarPlantaMedicinalChanged>((event, emit) {
      emit(
          state.copyWith(lugarPlantaMedicinalId: event.lugarPlantaMedicinalId));
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
    on<EnfermedadTratamientoChanged>((event, emit) {
      emit(state.copyWith(
          enfermedadTratamientoId: event.enfermedadTratamientoId));
    });
    on<PlantasMedicinalesChanged>((event, emit) {
      emit(state.copyWith(lstPlantasMedicinales: event.lstPlantasMedicinales));
    });
  }

  Future<void> saveAtencionSaludEspecialidadMedTradicional(
      int atencionSaludId) async {
    final result = await especialidadMedTradicionalUsecaseDB
        .saveEspecialidadesMedTradicionalAtencionSaludUsecaseDB(
            atencionSaludId, state.lstEspecialidadesMedTradicional!);
    result.fold((failure) {
      add(AtencionSaludFormSubmissionFailed(failure.properties.first));
    }, (data) async {
      await saveAtencionSaludEnfermedadesTradicionales(atencionSaludId);
    });
  }

  Future<void> saveAtencionSaludEnfermedadesTradicionales(
      int atencionSaludId) async {
    final result = await enfermedadTradicionalUsecaseDB
        .saveEnfermedadesTradicionalesAtencionSaludUsecaseDB(
            atencionSaludId, state.lstEnfermedadesTradicionales!);
    result.fold((failure) {
      add(AtencionSaludFormSubmissionFailed(failure.properties.first));
    }, (data) async {
      await saveAtencionSaludLugaresAtencionMedTradicional(atencionSaludId);
    });
  }

  Future<void> saveAtencionSaludLugaresAtencionMedTradicional(
      int atencionSaludId) async {
    final result = await lugarAtencionMedicoUsecaseDB
        .saveLugaresAtencionMedicoAtencionSaludUsecaseDB(
            atencionSaludId, state.lstLugaresAtencionMedico!);
    result.fold((failure) {
      add(AtencionSaludFormSubmissionFailed(failure.properties.first));
    }, (data) async {
      await saveAtencionSaludPlantasMedicinales(atencionSaludId);
    });
  }

  Future<void> saveAtencionSaludPlantasMedicinales(int atencionSaludId) async {
    final result = await plantaMedicinalUsecaseDB
        .savePlantasMedicinalesAtencionSaludUsecaseDB(
            atencionSaludId, state.lstPlantasMedicinales!);
    result.fold((failure) {
      add(AtencionSaludFormSubmissionFailed(failure.properties.first));
    }, (data) => add(AtencionSaludFormSubmissionSuccess(atencionSaludId)));
  }
}
