import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/nombre_enfermedad_model.dart';
import '../../../data/models/servicio_solicitado_model.dart';
import '../../../domain/entities/cuidado_salud_cond_riesgo_entity.dart';
import '../../../domain/usecases/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_db_usecase.dart';
import '../../../domain/usecases/nombre_enfermedad/nombre_enfermedad_db_usecase.dart';
import '../../../domain/usecases/servicio_solicitado/servicio_solicitado_db_usecase.dart';

part 'cuidado_salud_cond_riesgo_event.dart';
part 'cuidado_salud_cond_riesgo_state.dart';

class CuidadoSaludCondRiesgoBloc
    extends Bloc<CuidadoSaludCondRiesgoEvent, CuidadoSaludCondRiesgoEntity> {
  final CuidadoSaludCondRiesgoUsecaseDB cuidadoSaludCondRiesgoUsecaseDB;
  final ServicioSolicitadoUsecaseDB servicioSolicitadoUsecaseDB;
  final NombreEnfermedadUsecaseDB nombreEnfermedadUsecaseDB;

  CuidadoSaludCondRiesgoBloc(
      {required this.cuidadoSaludCondRiesgoUsecaseDB,
      required this.servicioSolicitadoUsecaseDB,
      required this.nombreEnfermedadUsecaseDB})
      : super(initObject()) {
    on<CuidadoSaludCondRiesgoInit>((event, emit) {
      emit(initObject());
    });

    on<CuidadoSaludCondRiesgoSubmitted>((event, emit) async {
      final result = await cuidadoSaludCondRiesgoUsecaseDB
          .saveCuidadoSaludCondRiesgoUsecaseDB(state);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: CuidadoSaludCondRiesgoSubmissionFailed(
                failure.properties.first)));
      }, (data) => saveServiciosSolicitados(data));
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
          emit(data);
          add(GetServiciosSolicitados(data.cuidadoSaludCondRiesgoId));
        } else {
          emit(state.copyWith(formStatus: CuidadoSaludCondRiesgoFormEmpty()));
        }
      });
    });

    on<GetServiciosSolicitados>((event, emit) async {
      final result = await servicioSolicitadoUsecaseDB
          .getLstServiciosSolicitadosUsecaseDB(event.cuidadoSaludCondRiesgoId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: CuidadoSaludCondRiesgoSubmissionFailed(
                failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
          lstServiciosSolicitados: data,
        ));
        add(GetNombresEnfermedades(event.cuidadoSaludCondRiesgoId));
      });
    });

    on<GetNombresEnfermedades>((event, emit) async {
      final result = await nombreEnfermedadUsecaseDB
          .getLstNombresEnfermedadesUsecaseDB(event.cuidadoSaludCondRiesgoId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: CuidadoSaludCondRiesgoSubmissionFailed(
                failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
            lstNombresEnfermedades: data,
            formStatus: CuidadoSaludCondRiesgoFormLoaded()));
      });
    });

    on<CuidadoSaludCondRiesgoFormSubmissionSuccess>((event, emit) {
      emit(state.copyWith(
        cuidadoSaludCondRiesgoId: event.cuidadoSaludCondRiesgoId,
        formStatus: CuidadoSaludCondRiesgoSubmissionSuccess(),
      ));
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

  void saveServiciosSolicitados(int cuidadoSaludCondRiesgoId) async {
    final result =
        await servicioSolicitadoUsecaseDB.saveServiciosSolicitadosUsecaseDB(
            cuidadoSaludCondRiesgoId, state.lstServiciosSolicitados!);
    result.fold((failure) {
      add(CuidadoSaludCondRiesgoFormSubmissionFailed(failure.properties.first));
    }, (data) => saveNombresEnfermedades(cuidadoSaludCondRiesgoId));
  }

  void saveNombresEnfermedades(int cuidadoSaludCondRiesgoId) async {
    final result =
        await nombreEnfermedadUsecaseDB.saveNombresEnfermedadesUsecaseDB(
            cuidadoSaludCondRiesgoId, state.lstNombresEnfermedades!);
    result.fold((failure) {
      add(CuidadoSaludCondRiesgoFormSubmissionFailed(failure.properties.first));
    }, (data) {
      add(CuidadoSaludCondRiesgoFormSubmissionSuccess(
          cuidadoSaludCondRiesgoId));
    });
  }
}
