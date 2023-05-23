import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/dim_ubicacion/dim_ubicacion_db_usecase.dart';

part 'dim_ubicacion_event.dart';
part 'dim_ubicacion_state.dart';

class DimUbicacionBloc extends Bloc<DimUbicacionEvent, DimUbicacionEntity> {
  final DimUbicacionUsecaseDB dimUbicacionUsecaseDB;

  DimUbicacionBloc({required this.dimUbicacionUsecaseDB})
      : super(initObject()) {
    on<DimUbicacionInit>((event, emit) {
      emit(initObject());
    });

    on<DimUbicacionSubmitted>((event, emit) async {
      final result =
          await dimUbicacionUsecaseDB.saveDimUbicacionUsecaseDB(state);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      },
          (data) => emit(
              state.copyWith(formStatus: DimUbicacionSubmissionSuccess())));
    });

    on<GetDimUbicacion>((event, emit) async {
      final result =
          await dimUbicacionUsecaseDB.getDimUbicacionUsecaseDB(event.familiaId);
      result.fold(
          (failure) => emit(state.copyWith(
              formStatus:
                  DimUbicacionSubmissionFailed(failure.properties.first))),
          (data) {
        if (data != null) {
          emit(data.copyWith(formStatus: DimUbicacionFormLoaded()));
        } else {
          emit(state.copyWith(formStatus: DimUbicacionFormEmpty()));
        }
      });
    });

    on<UbicacionChanged>((event, emit) {
      emit(state.copyWith(ubicacionId: event.ubicacionId));
    });
    on<DimUbicacionFamiliaChanged>((event, emit) {
      emit(state.copyWith(familiaId: event.familiaId));
    });
    on<NombreRecibeVisitaChanged>((event, emit) {
      emit(state.copyWith(nombreRecibeVisita: event.nombreRecibeVisita));
    });
    on<TipoDocRecibeVisitaChanged>((event, emit) {
      emit(state.copyWith(tipoDocRecibeVisita: event.tipoDocRecibeVisita));
    });
    on<DocumentoRecibeVisitaChanged>((event, emit) {
      emit(state.copyWith(documentoRecibeVisita: event.documentoRecibeVisita));
    });
    on<PerteneceResguardoChanged>((event, emit) {
      emit(state.copyWith(perteneceResguardo: event.perteneceResguardo));
    });
    on<ViaAccesoChanged>((event, emit) {
      emit(state.copyWith(viaAccesoId: event.viaAccesoId));
    });
    on<ResguardoChanged>((event, emit) {
      emit(state.copyWith(resguardoId: event.resguardoId));
    });
    on<AutoridadIndigenaChanged>((event, emit) {
      emit(state.copyWith(autoridadIndigenaId: event.autoridadIndigenaId));
    });
    on<EstadoViaChanged>((event, emit) {
      emit(state.copyWith(estadoViaId: event.estadoViaId));
    });
    on<MediosComunicacionChanged>((event, emit) {
      emit(state.copyWith(mediosComunicacionIds: event.mediosComunicacionIds));
    });
    on<TiempoTardaChanged>((event, emit) {
      emit(state.copyWith(tiempoTardaId: event.tiempoTardaId));
    });
    on<MediosUtilizaCAChanged>((event, emit) {
      emit(state.copyWith(mediosUtilizaIds: event.mediosUtilizaIds));
    });
    on<DificultadesAccesoCAChanged>((event, emit) {
      emit(state.copyWith(dificultadesAccesoIds: event.dificultadesAccesoIds));
    });
    on<CostoDesplazamientoChanged>((event, emit) {
      emit(state.copyWith(costoDesplazamientoId: event.costoDesplazamientoId));
    });
    on<ExisteMedTradicionalComunidadChanged>((event, emit) {
      emit(state.copyWith(
          existeMedTradicionalComunidad: event.existeMedTradicionalComunidad));
    });
    on<EspecialidadesMedTradChanged>((event, emit) {
      emit(state.copyWith(
          especialidadesMedTradIds: event.especialidadesMedTradIds));
    });
    on<TiempoTardaMedTradChanged>((event, emit) {
      emit(state.copyWith(tiempoTardaMedTradId: event.tiempoTardaMedTradId));
    });
    on<MediosUtilizaMedTradChanged>((event, emit) {
      emit(state.copyWith(
          mediosUtilizaMedTradIds: event.mediosUtilizaMedTradIds));
    });
    on<DificultadesAccesoMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(
          dificultadesAccesoMedTradIds: event.dificultadesAccesoMedTradIds));
    });
    on<CostoDesplazamientoMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(
          costoDesplazamientoMedTradicional:
              event.costoDesplazamientoMedTradicional));
    });
    on<NombresMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(nombresMedTradicional: event.nombresMedTradicional));
    });
    on<PoseeChagraChanged>((event, emit) {
      emit(state.copyWith(poseeChagra: event.poseeChagra));
    });
    on<TuberculosPlatanosChanged>((event, emit) {
      emit(state.copyWith(tuberculosPlatanosIds: event.tuberculosPlatanosIds));
    });
    on<LeguminosasChanged>((event, emit) {
      emit(state.copyWith(leguminosasIds: event.leguminosasIds));
    });
    on<HortalizasChanged>((event, emit) {
      emit(state.copyWith(hortalizasIds: event.hortalizasIds));
    });
    on<VerdurasChanged>((event, emit) {
      emit(state.copyWith(verdurasIds: event.verdurasIds));
    });
    on<FrutosChanged>((event, emit) {
      emit(state.copyWith(frutosIds: event.frutosIds));
    });
    on<CerealesChanged>((event, emit) {
      emit(state.copyWith(cerealesIds: event.cerealesIds));
    });
    on<EspeciesAnimalesCriaChanged>((event, emit) {
      emit(state.copyWith(
          especiesAnimalesCriaIds: event.especiesAnimalesCriaIds));
    });
    on<ProduccionMineraChanged>((event, emit) {
      emit(state.copyWith(produccionMinera: event.produccionMineraId));
    });
    on<TiposCalendariosChanged>((event, emit) {
      emit(state.copyWith(tiposCalendariosIds: event.tiposCalendariosIds));
    });
  }
}
