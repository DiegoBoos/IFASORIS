import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/cereal_model.dart';
import '../../../data/models/dificultad_acceso_ca_model.dart';
import '../../../data/models/dificultad_acceso_med_tradicional_model.dart';
import '../../../data/models/especialidad_med_tradicional_model.dart';
import '../../../data/models/especie_animal_model.dart';
import '../../../data/models/fruto_model.dart';
import '../../../data/models/hortaliza_model.dart';
import '../../../data/models/leguminosa_model.dart';
import '../../../data/models/medio_comunicacion_model.dart';
import '../../../data/models/medio_utiliza_med_tradicional_model.dart';
import '../../../data/models/nombre_med_tradicional_model.dart';
import '../../../data/models/tuberculo_platano_model.dart';
import '../../../data/models/verdura_model.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/cereal_by_dpto/cereal_by_dpto_db_usecase.dart';
import '../../../domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_db_usecase.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_db_usecase.dart';
import '../../../domain/usecases/dim_ubicacion/dim_ubicacion_db_usecase.dart';
import '../../../domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_db_usecase.dart';
import '../../../domain/usecases/especie_animal_by_dpto/especie_animal_by_dpto_db_usecase.dart';
import '../../../domain/usecases/fruto_by_dpto/fruto_by_dpto_db_usecase.dart';
import '../../../domain/usecases/hortaliza_by_dpto/hortaliza_by_dpto_db_usecase.dart';
import '../../../domain/usecases/leguminosa_by_dpto/leguminosa_by_dpto_db_usecase.dart';
import '../../../domain/usecases/medio_comunicacion/medio_comunicacion_db_usecase.dart';
import '../../../domain/usecases/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_db_usecase.dart';
import '../../../domain/usecases/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_db_usecase.dart';
import '../../../domain/usecases/verdura_by_dpto/verdura_by_dpto_db_usecase.dart';

part 'dim_ubicacion_event.dart';
part 'dim_ubicacion_state.dart';

class DimUbicacionBloc extends Bloc<DimUbicacionEvent, DimUbicacionEntity> {
  final DimUbicacionUsecaseDB dimUbicacionUsecaseDB;
  final DificultadAccesoMedTradicionalByDptoUsecaseDB
      dificultadAccesoMedTradicionalByDptoUsecaseDB;
  final CerealByDptoUsecaseDB cerealByDptoUsecaseDB;
  final DificultadAccesoCAUsecaseDB dificultadAccesoCAUsecaseDB;
  final EspecialidadMedTradicionalUsecaseDB especialidadMedTradicionalUsecaseDB;
  final EspecieAnimalByDptoUsecaseDB especieAnimalByDptoUsecaseDB;
  final FrutoByDptoUsecaseDB frutoByDptoUsecaseDB;
  final HortalizaByDptoUsecaseDB hortalizaByDptoUsecaseDB;
  final LeguminosaByDptoUsecaseDB leguminosaByDptoUsecaseDB;
  final MedioComunicacionUsecaseDB medioComunicacionUsecaseDB;
  final MedioUtilizaMedTradicionalByDptoUsecaseDB
      medioUtilizaMedTradicionalByDptoUsecaseDB;
  final TuberculoPlatanoByDptoUsecaseDB tuberculoPlatanoByDptoUsecaseDB;
  final VerduraByDptoUsecaseDB verduraByDptoUsecaseDB;

  DimUbicacionBloc({
    required this.dimUbicacionUsecaseDB,
    required this.dificultadAccesoMedTradicionalByDptoUsecaseDB,
    required this.cerealByDptoUsecaseDB,
    required this.dificultadAccesoCAUsecaseDB,
    required this.especialidadMedTradicionalUsecaseDB,
    required this.especieAnimalByDptoUsecaseDB,
    required this.frutoByDptoUsecaseDB,
    required this.hortalizaByDptoUsecaseDB,
    required this.leguminosaByDptoUsecaseDB,
    required this.medioComunicacionUsecaseDB,
    required this.medioUtilizaMedTradicionalByDptoUsecaseDB,
    required this.tuberculoPlatanoByDptoUsecaseDB,
    required this.verduraByDptoUsecaseDB,
  }) : super(initObject()) {
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
      }, (data) => saveUbicacionAccesoMedTradicional(data));
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

    on<DimUbicacionFormSubmissionSuccess>((event, emit) {
      emit(state.copyWith(
        ubicacionId: event.ubicacionId,
        formStatus: DimUbicacionSubmissionSuccess(),
      ));
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
      emit(state.copyWith(lstMediosComunica: event.lstMediosComunica));
    });
    on<TiempoTardaChanged>((event, emit) {
      emit(state.copyWith(tiempoTardaId: event.tiempoTardaId));
    });
    on<MedioUtilizaCAChanged>((event, emit) {
      emit(state.copyWith(medioUtilizaId: event.medioUtilizaId));
    });
    on<DificultadesAccesoCAChanged>((event, emit) {
      emit(state.copyWith(
          lstDificultadAccesoAtencion: event.lstDificultadAccesoAtencion));
    });
    on<CostoDesplazamientoChanged>((event, emit) {
      emit(state.copyWith(costoDesplazamientoId: event.costoDesplazamientoId));
    });
    on<ExisteMedTradicionalComunidadChanged>((event, emit) {
      emit(state.copyWith(
          existeMedTradicionalComunidad: event.existeMedTradicionalComunidad));
    });
    on<EspecialidadesMedTradChanged>((event, emit) {
      emit(state.copyWith(lstEspMedTradicional: event.lstEspMedTradicional));
    });
    on<TiempoTardaMedTradChanged>((event, emit) {
      emit(state.copyWith(tiempoTardaMedTradId: event.tiempoTardaMedTradId));
    });
    on<MediosUtilizaMedTradChanged>((event, emit) {
      emit(state.copyWith(
          lstMediosMedTradicional: event.lstMediosMedTradicional));
    });
    on<DificultadesAccesoMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(
          lstDificultadAccesoMedTradicional:
              event.lstDificultadAccesoMedTradicional));
    });
    on<CostoDesplazamientoMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(
          costoDesplazamientoMedTradicional:
              event.costoDesplazamientoMedTradicional));
    });
    on<NombresMedTradicionalChanged>((event, emit) {
      emit(state.copyWith(
          lstNombreMedTradicional: event.lstNombreMedTradicional));
    });
    on<PoseeChagraChanged>((event, emit) {
      emit(state.copyWith(poseeChagra: event.poseeChagra));
    });
    on<TuberculosPlatanosChanged>((event, emit) {
      emit(state.copyWith(lstTuberculos: event.lstTuberculos));
    });
    on<LeguminosasChanged>((event, emit) {
      emit(state.copyWith(lstLeguminosas: event.lstLeguminosas));
    });
    on<HortalizasChanged>((event, emit) {
      emit(state.copyWith(lstHortalizas: event.lstHortalizas));
    });
    on<VerdurasChanged>((event, emit) {
      emit(state.copyWith(lstVerduras: event.lstVerduras));
    });
    on<FrutosChanged>((event, emit) {
      emit(state.copyWith(lstFrutos: event.lstFrutos));
    });
    on<CerealesChanged>((event, emit) {
      emit(state.copyWith(lstCereales: event.lstCereales));
    });
    on<EspeciesAnimalesCriaChanged>((event, emit) {
      emit(state.copyWith(lstAnimalCria: event.lstAnimalCria));
    });
    on<ProduccionMineraChanged>((event, emit) {
      emit(state.copyWith(produccionMinera: event.produccionMineraId));
    });
    on<TipoCalendarioChanged>((event, emit) {
      emit(state.copyWith(tipoCalendarioId: event.tipoCalendarioId));
    });
  }

  void saveUbicacionAccesoMedTradicional(int ubicacionId) async {
    final result = await dificultadAccesoMedTradicionalByDptoUsecaseDB
        .saveUbicacionAccesoMedTradicionalUsecaseDB(
            ubicacionId, state.lstDificultadAccesoMedTradicional!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionCereales(ubicacionId));
  }

  void saveUbicacionCereales(int ubicacionId) async {
    final result = await cerealByDptoUsecaseDB.saveUbicacionCerealesUsecaseDB(
        ubicacionId, state.lstCereales!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionDificultadAcceso(ubicacionId));
  }

  void saveUbicacionDificultadAcceso(int ubicacionId) async {
    final result = await dificultadAccesoCAUsecaseDB
        .saveUbicacionDificultadesAccesoUsecaseDB(
            ubicacionId, state.lstDificultadAccesoAtencion!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionEspecialidadMedTradicional(ubicacionId));
  }

  void saveUbicacionEspecialidadMedTradicional(int ubicacionId) async {
    final result = await especialidadMedTradicionalUsecaseDB
        .saveUbicacionEspecialidadMedTradicionalUsecaseDB(
            ubicacionId, state.lstEspMedTradicional!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionEspecieAnimalesCria(ubicacionId));
  }

  void saveUbicacionEspecieAnimalesCria(int ubicacionId) async {
    final result = await especieAnimalByDptoUsecaseDB
        .saveUbicacionEspecieAnimalesCriaUsecaseDB(
            ubicacionId, state.lstAnimalCria!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionFrutos(ubicacionId));
  }

  void saveUbicacionFrutos(int ubicacionId) async {
    final result = await frutoByDptoUsecaseDB.saveUbicacionFrutosUsecaseDB(
        ubicacionId, state.lstFrutos!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionHortalizas(ubicacionId));
  }

  void saveUbicacionHortalizas(int ubicacionId) async {
    final result = await hortalizaByDptoUsecaseDB
        .saveUbicacionHortalizasUsecaseDB(ubicacionId, state.lstHortalizas!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionLeguminosas(ubicacionId));
  }

  void saveUbicacionLeguminosas(int ubicacionId) async {
    final result = await leguminosaByDptoUsecaseDB
        .saveUbicacionLeguminosasUsecaseDB(ubicacionId, state.lstLeguminosas!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionMediosComunicacion(ubicacionId));
  }

  void saveUbicacionMediosComunicacion(int ubicacionId) async {
    final result = await medioComunicacionUsecaseDB
        .saveUbicacionMediosComunicacionUsecaseDB(
            ubicacionId, state.lstMediosComunica!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionMediosMedTradicional(ubicacionId));
  }

  void saveUbicacionMediosMedTradicional(int ubicacionId) async {
    final result = await medioUtilizaMedTradicionalByDptoUsecaseDB
        .saveUbicacionMediosMedTradicionalUsecaseDB(
            ubicacionId, state.lstMediosMedTradicional!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionNombresMedTradicional(ubicacionId));
  }

  void saveUbicacionNombresMedTradicional(int ubicacionId) async {
    final result = await especialidadMedTradicionalUsecaseDB
        .saveUbicacionNombresMedTradicionalUsecaseDB(
            ubicacionId, state.lstNombreMedTradicional!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionTuberculosPlatanos(ubicacionId));
  }

  void saveUbicacionTuberculosPlatanos(int ubicacionId) async {
    final result = await tuberculoPlatanoByDptoUsecaseDB
        .saveUbicacionTuberculosPlatanosUsecaseDB(
            ubicacionId, state.lstTuberculos!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => saveUbicacionVerduras(ubicacionId));
  }

  void saveUbicacionVerduras(int ubicacionId) async {
    final result = await verduraByDptoUsecaseDB.saveUbicacionVerdurasUsecaseDB(
        ubicacionId, state.lstVerduras!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => add(DimUbicacionFormSubmissionSuccess(ubicacionId)));
  }
}
