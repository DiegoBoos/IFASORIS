import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/nombre_enfermedad_model.dart';
import '../../../data/models/servicio_solicitado_model.dart';
import '../../../domain/entities/cuidado_salud_cond_riesgo_entity.dart';
import '../../../domain/usecases/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_db_usecase.dart';

part 'cuidado_salud_cond_riesgo_event.dart';
part 'cuidado_salud_cond_riesgo_state.dart';

class CuidadoSaludCondRiesgoBloc
    extends Bloc<CuidadoSaludCondRiesgoEvent, CuidadoSaludCondRiesgoEntity> {
  final CuidadoSaludCondRiesgoUsecaseDB cuidadoSaludCondRiesgoUsecaseDB;

  CuidadoSaludCondRiesgoBloc({required this.cuidadoSaludCondRiesgoUsecaseDB})
      : super(initObject()) {
    on<CuidadoSaludCondRiesgoInit>((event, emit) {
      emit(initObject());
    });

    on<CuidadoSaludCondRiesgoSubmitted>((event, emit) async {
      final result = await cuidadoSaludCondRiesgoUsecaseDB
          .saveCuidadoSaludCondRiesgoUsecaseDB(event.cuidadoSaludCondRiesgo);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: CuidadoSaludCondRiesgoSubmissionFailed(
                failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
            formStatus: CuidadoSaludCondRiesgoSubmissionSuccess()));
      });
    });

    on<GetCuidadoSaludCondRiesgo>((event, emit) async {
      final result = await cuidadoSaludCondRiesgoUsecaseDB
          .getCuidadoSaludCondRiesgoUsecaseDB(event.afiliadoId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: CuidadoSaludCondRiesgoSubmissionFailed(
                failure.properties.first)));
      }, (data) {
        if (data != null) {
          emit(data.copyWith(formStatus: CuidadoSaludCondRiesgoFormLoaded()));
        } else {
          emit(state.copyWith(formStatus: CuidadoSaludCondRiesgoFormEmpty()));
        }
      });
    });

    on<CuidadoSaludCondRiesgoChanged>((event, emit) {
      emit(state.copyWith(
          cuidadoSaludCondRiesgoId: event.cuidadoSaludCondRiesgoId));
    });
    on<AfiliadoChanged>((event, emit) {
      emit(state.copyWith(afiliadoId: event.afiliadoId));
    });
    on<FamiliaChanged>((event, emit) {
      emit(state.copyWith(familiaId: event.familiaId));
    });
    on<UltimaVezInstSaludChanged>((event, emit) {
      emit(state.copyWith(ultimaVezInstSaludId: event.ultimaVezInstSaludId));
    });
    on<SeguimientoEnfermedadChanged>((event, emit) {
      emit(state.copyWith(
          seguimientoEnfermedadId: event.seguimientoEnfermedadId));
    });
    on<CondicionNutricionalChanged>((event, emit) {
      emit(
          state.copyWith(condicionNutricionalId: event.condicionNutricionalId));
    });
    on<TosFlemaChanged>((event, emit) {
      emit(state.copyWith(tosFlemaId: event.tosFlemaId));
    });
    on<ManchasPielChanged>((event, emit) {
      emit(state.copyWith(manchasPielId: event.manchasPielId));
    });
    on<CarnetVacunacionChanged>((event, emit) {
      emit(state.copyWith(carnetVacunacionId: event.carnetVacunacionId));
    });
    on<EsquemaVacunacionChanged>((event, emit) {
      emit(state.copyWith(esquemaVacunacionId: event.esquemaVacunacionId));
    });
    on<LugarVacunacionChanged>((event, emit) {
      emit(state.copyWith(lugarVacunacionId: event.lugarVacunacionId));
    });
    on<UtilizaMetodoPlanificacionChanged>((event, emit) {
      emit(state.copyWith(
          utilizaMetodoPlanificacionId: event.utilizaMetodoPlanificacionId));
    });
    on<MetodoPlanificacionChanged>((event, emit) {
      emit(state.copyWith(metodoPlanificacionId: event.metodoPlanificacionId));
    });
    on<ConductaSeguirChanged>((event, emit) {
      emit(state.copyWith(conductaSeguirId: event.conductaSeguirId));
    });
    on<NombresEnfermedadesChanged>((event, emit) {
      emit(
          state.copyWith(lstNombresEnfermedades: event.lstNombresEnfermedades));
    });
    on<ServiciosSolicitadosChanged>((event, emit) {
      emit(state.copyWith(
          lstServiciosSolicitados: event.lstServiciosSolicitados));
    });
  }
}
