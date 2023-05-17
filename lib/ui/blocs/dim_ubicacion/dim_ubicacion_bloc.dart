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
    on<MedioComunicacionChanged>((event, emit) {
      emit(state.copyWith(medioComunicacionId: event.medioComunicacionId));
    });
    on<TiempoTardaChanged>((event, emit) {
      emit(state.copyWith(tiempoTardaId: event.tiempoTardaId));
    });
    on<MedioUtilizaChanged>((event, emit) {
      emit(state.copyWith(medioUtilizaId: event.medioUtilizaId));
    });
    on<DificultaAccesoChanged>((event, emit) {
      emit(state.copyWith(dificultaAccesoId: event.dificultaAccesoId));
    });
    on<CostoDesplazamientoChanged>((event, emit) {
      emit(state.copyWith(costoDesplazamientoId: event.costoDesplazamientoId));
    });
    on<ExisteMedTradicionalComunidadChanged>((event, emit) {
      emit(state.copyWith(
          existeMedTradicionalComunidad: event.existeMedTradicionalComunidad));
    });
    on<EspecialidadMedTradChanged>((event, emit) {
      emit(state.copyWith(especialidadMedTradId: event.especialidadMedTradId));
    });
    on<TiempoTardaMedTradChanged>((event, emit) {
      emit(state.copyWith(tiempoTardaMedTradId: event.tiempoTardaMedTradId));
    });
    on<MedioUtilizaMedTradChanged>((event, emit) {
      emit(state.copyWith(medioUtilizaMedTradId: event.medioUtilizaMedTradId));
    });
    on<DificultadAccesoMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(
          dificultadAccesoMedTradId: event.dificultadAccesoMedTradicionalId));
    });
    on<CostoDesplazamientoMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(
          costoDesplazamientoMedTradicional:
              event.costoDesplazamientoMedTradicional));
    });
    on<NombreMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(nombreMedTradicional: event.nombreMedTradicional));
    });
    on<PoseeChagraChanged>((event, emit) {
      emit(state.copyWith(poseeChagra: event.poseeChagra));
    });
    on<TuberculoPlatanoChanged>((event, emit) {
      emit(state.copyWith(tuberculoPlatanoId: event.tuberculoPlatanoId));
    });
    on<LeguminosaChanged>((event, emit) {
      emit(state.copyWith(leguminosaId: event.leguminosaId));
    });
    on<HortalizaChanged>((event, emit) {
      emit(state.copyWith(hortalizaId: event.hortalizaId));
    });
    on<VerduraChanged>((event, emit) {
      emit(state.copyWith(verduraId: event.verduraId));
    });
    on<FrutoChanged>((event, emit) {
      emit(state.copyWith(frutoId: event.frutoId));
    });
    on<CerealChanged>((event, emit) {
      emit(state.copyWith(cerealId: event.cerealId));
    });
    on<EspecieAnimalCriaChanged>((event, emit) {
      emit(state.copyWith(especieAnimalCriaId: event.especieAnimalCriaId));
    });
    on<ProduccionMineraChanged>((event, emit) {
      emit(state.copyWith(produccionMinera: event.produccionMineraId));
    });
    on<TipoCalendarioChanged>((event, emit) {
      emit(state.copyWith(tipoCalendarioId: event.tipoCalendarioId));
    });
  }
}
