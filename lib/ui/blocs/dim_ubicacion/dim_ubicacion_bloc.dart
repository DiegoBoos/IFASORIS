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
import '../../../data/models/medio_utiliza_ca_model.dart';
import '../../../data/models/medio_utiliza_med_tradicional_model.dart';
import '../../../data/models/nombre_med_tradicional_model.dart';
import '../../../data/models/tuberculo_platano_model.dart';
import '../../../data/models/verdura_model.dart';
import '../../../domain/usecases/cereal/cereal_exports.dart';
import '../../../domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_exports.dart';
import '../../../domain/usecases/dim_ubicacion/dim_ubicacion_exports.dart';
import '../../../domain/usecases/especialidad_med_tradicional/especialidad_med_tradicional_exports.dart';
import '../../../domain/usecases/especie_animal/especie_animal_exports.dart';
import '../../../domain/usecases/fruto/fruto_exports.dart';
import '../../../domain/usecases/hortaliza/hortaliza_exports.dart';
import '../../../domain/usecases/leguminosa/leguminosa_exports.dart';
import '../../../domain/usecases/medio_comunicacion/medio_comunicacion_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_exports.dart';
import '../../../domain/usecases/tuberculo_platano/tuberculo_platano_exports.dart';
import '../../../domain/usecases/verdura/verdura_exports.dart';

part 'dim_ubicacion_event.dart';
part 'dim_ubicacion_state.dart';

class DimUbicacionBloc extends Bloc<DimUbicacionEvent, DimUbicacionEntity> {
  final DimUbicacionUsecaseDB dimUbicacionUsecaseDB;
  final DificultadAccesoMedTradicionalUsecaseDB
      dificultadAccesoMedTradicionalUsecaseDB;
  final CerealUsecaseDB cerealUsecaseDB;
  final DificultadAccesoCAUsecaseDB dificultadAccesoCAUsecaseDB;
  final EspecialidadMedTradicionalUsecaseDB especialidadMedTradicionalUsecaseDB;
  final EspecieAnimalUsecaseDB especieAnimalUsecaseDB;
  final FrutoUsecaseDB frutoUsecaseDB;
  final HortalizaUsecaseDB hortalizaUsecaseDB;
  final LeguminosaUsecaseDB leguminosaUsecaseDB;
  final MedioComunicacionUsecaseDB medioComunicacionUsecaseDB;
  final MedioUtilizaCAUsecaseDB medioUtilizaCAUsecaseDB;
  final MedioUtilizaMedTradicionalUsecaseDB medioUtilizaMedTradicionalUsecaseDB;
  final TuberculoPlatanoUsecaseDB tuberculoPlatanoUsecaseDB;
  final VerduraUsecaseDB verduraUsecaseDB;

  DimUbicacionBloc({
    required this.dimUbicacionUsecaseDB,
    required this.dificultadAccesoMedTradicionalUsecaseDB,
    required this.cerealUsecaseDB,
    required this.dificultadAccesoCAUsecaseDB,
    required this.especialidadMedTradicionalUsecaseDB,
    required this.especieAnimalUsecaseDB,
    required this.frutoUsecaseDB,
    required this.hortalizaUsecaseDB,
    required this.leguminosaUsecaseDB,
    required this.medioComunicacionUsecaseDB,
    required this.medioUtilizaCAUsecaseDB,
    required this.medioUtilizaMedTradicionalUsecaseDB,
    required this.tuberculoPlatanoUsecaseDB,
    required this.verduraUsecaseDB,
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
      }, (data) async => await saveUbicacionAccesoMedTradicional(data));
    });

    on<GetDimUbicacion>((event, emit) async {
      final result = await dimUbicacionUsecaseDB.getDimUbicacionUsecaseDB(
          event.afiliadoId, event.familiaId);
      result.fold(
          (failure) => emit(state.copyWith(
              formStatus:
                  DimUbicacionSubmissionFailed(failure.properties.first))),
          (data) {
        if (data != null) {
          emit(data);
          add(GetDificultadesAcceso(data.ubicacionId));
        } else {
          emit(state.copyWith(formStatus: DimUbicacionFormEmpty()));
        }
      });
    });

    on<GetDificultadesAcceso>((event, emit) async {
      final result = await dificultadAccesoCAUsecaseDB
          .getUbicacionDificultadesAccesoUsecaseDB(event.ubicacionId);
      result.fold(
          (failure) => emit(state.copyWith(
              formStatus:
                  DimUbicacionSubmissionFailed(failure.properties.first))),
          (data) {
        emit(state.copyWith(lstDificultadAccesoAtencion: data));
        add(GetEspecialidadesMedTradicional(event.ubicacionId));
      });
    });

    on<GetEspecialidadesMedTradicional>((event, emit) async {
      final result = await especialidadMedTradicionalUsecaseDB
          .getUbicacionEspecialidadesMedTradicionalUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstEspMedTradicional: data));
        add(GetNombresMedTrad(event.ubicacionId));
      });
    });

    on<GetNombresMedTrad>((event, emit) async {
      final result = await especialidadMedTradicionalUsecaseDB
          .getUbicacionNombresMedTradicionalUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstNombreMedTradicional: data));
        add(GetMediosUtilizaMedTradicional(event.ubicacionId));
      });
    });

    on<GetMediosUtilizaMedTradicional>((event, emit) async {
      final result = await medioUtilizaMedTradicionalUsecaseDB
          .getUbicacionMediosUtilizaMedTradicionalUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstMediosMedTradicional: data));
        add(GetDificultadesAccesoMedTradicional(event.ubicacionId));
      });
    });

    on<GetDificultadesAccesoMedTradicional>((event, emit) async {
      final result = await dificultadAccesoMedTradicionalUsecaseDB
          .getUbicacionDificultadesAccesoMedTradicionalUsecaseDB(
              event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstDificultadAccesoMedTradicional: data));
        add(GetTuberculosPlatanos(event.ubicacionId));
      });
    });

    on<GetTuberculosPlatanos>((event, emit) async {
      final result = await tuberculoPlatanoUsecaseDB
          .getUbicacionTuberculosPlatanosUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstTuberculos: data));
        add(GetLeguminosas(event.ubicacionId));
      });
    });

    on<GetLeguminosas>((event, emit) async {
      final result = await leguminosaUsecaseDB
          .getUbicacionLeguminosasUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstLeguminosas: data));
        add(GetHortalizas(event.ubicacionId));
      });
    });

    on<GetHortalizas>((event, emit) async {
      final result = await hortalizaUsecaseDB
          .getUbicacionHortalizasUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstHortalizas: data));
        add(GetVerduras(event.ubicacionId));
      });
    });

    on<GetVerduras>((event, emit) async {
      final result = await verduraUsecaseDB
          .getUbicacionVerdurasUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstVerduras: data));
        add(GetFrutos(event.ubicacionId));
      });
    });

    on<GetFrutos>((event, emit) async {
      final result =
          await frutoUsecaseDB.getUbicacionFrutosUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstFrutos: data));
        add(GetCereales(event.ubicacionId));
      });
    });

    on<GetCereales>((event, emit) async {
      final result = await cerealUsecaseDB
          .getUbicacionCerealesUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstCereales: data));
        add(GetEspeciesAnimales(event.ubicacionId));
      });
    });

    on<GetEspeciesAnimales>((event, emit) async {
      final result = await especieAnimalUsecaseDB
          .getUbicacionEspeciesAnimalesUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstAnimalCria: data));
        add(GetMediosComunicacion(event.ubicacionId));
      });
    });

    on<GetMediosComunicacion>((event, emit) async {
      final result = await medioComunicacionUsecaseDB
          .getUbicacionMediosComunicacionUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstMediosComunica: data));
        add(GetMediosUtilizaCA(event.ubicacionId));
      });
    });

    on<GetMediosUtilizaCA>((event, emit) async {
      final result = await medioUtilizaCAUsecaseDB
          .getUbicacionMediosUtilizaCAUsecaseDB(event.ubicacionId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                DimUbicacionSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
            lstMediosUtilizaCA: data, formStatus: DimUbicacionFormLoaded()));
      });
    });

    on<DimUbicacionFormSubmissionSuccess>((event, emit) {
      emit(state.copyWith(
        ubicacionId: event.ubicacionId,
        formStatus: DimUbicacionSubmissionSuccess(),
      ));
    });

    on<DimUbicacionAfiliadoChanged>((event, emit) {
      emit(state.copyWith(afiliadoId: event.afiliadoId));
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
    on<MediosUtilizaCAChanged>((event, emit) {
      emit(state.copyWith(lstMediosUtilizaCA: event.lstMediosUtilizaCA));
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

  Future<void> saveUbicacionAccesoMedTradicional(int ubicacionId) async {
    final result = await dificultadAccesoMedTradicionalUsecaseDB
        .saveUbicacionAccesoMedTradicionalUsecaseDB(
            ubicacionId, state.lstDificultadAccesoMedTradicional!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionCereales(ubicacionId));
  }

  Future<void> saveUbicacionCereales(int ubicacionId) async {
    final result = await cerealUsecaseDB.saveUbicacionCerealesUsecaseDB(
        ubicacionId, state.lstCereales!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionDificultadAcceso(ubicacionId));
  }

  Future<void> saveUbicacionDificultadAcceso(int ubicacionId) async {
    final result = await dificultadAccesoCAUsecaseDB
        .saveUbicacionDificultadesAccesoUsecaseDB(
            ubicacionId, state.lstDificultadAccesoAtencion!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async {
      await saveUbicacionEspecialidadMedTradicional(ubicacionId);
    });
  }

  Future<void> saveUbicacionEspecialidadMedTradicional(int ubicacionId) async {
    final result = await especialidadMedTradicionalUsecaseDB
        .saveUbicacionEspecialidadMedTradicionalUsecaseDB(
            ubicacionId, state.lstEspMedTradicional!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionEspecieAnimalesCria(ubicacionId));
  }

  Future<void> saveUbicacionEspecieAnimalesCria(int ubicacionId) async {
    final result =
        await especieAnimalUsecaseDB.saveUbicacionEspecieAnimalesCriaUsecaseDB(
            ubicacionId, state.lstAnimalCria!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionFrutos(ubicacionId));
  }

  Future<void> saveUbicacionFrutos(int ubicacionId) async {
    final result = await frutoUsecaseDB.saveUbicacionFrutosUsecaseDB(
        ubicacionId, state.lstFrutos!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionHortalizas(ubicacionId));
  }

  Future<void> saveUbicacionHortalizas(int ubicacionId) async {
    final result = await hortalizaUsecaseDB.saveUbicacionHortalizasUsecaseDB(
        ubicacionId, state.lstHortalizas!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionLeguminosas(ubicacionId));
  }

  Future<void> saveUbicacionLeguminosas(int ubicacionId) async {
    final result = await leguminosaUsecaseDB.saveUbicacionLeguminosasUsecaseDB(
        ubicacionId, state.lstLeguminosas!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionMediosComunicacion(ubicacionId));
  }

  Future<void> saveUbicacionMediosComunicacion(int ubicacionId) async {
    final result = await medioComunicacionUsecaseDB
        .saveUbicacionMediosComunicacionUsecaseDB(
            ubicacionId, state.lstMediosComunica!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionMediosUtilizaCAChanged(ubicacionId));
  }

  Future<void> saveUbicacionMediosUtilizaCAChanged(int ubicacionId) async {
    final result =
        await medioUtilizaCAUsecaseDB.saveUbicacionMediosUtilizaCAUsecaseDB(
            ubicacionId, state.lstMediosUtilizaCA!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionMediosMedTradicional(ubicacionId));
  }

  Future<void> saveUbicacionMediosMedTradicional(int ubicacionId) async {
    final result = await medioUtilizaMedTradicionalUsecaseDB
        .saveUbicacionMediosMedTradicionalUsecaseDB(
            ubicacionId, state.lstMediosMedTradicional!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionNombresMedTradicional(ubicacionId));
  }

  Future<void> saveUbicacionNombresMedTradicional(int ubicacionId) async {
    final result = await especialidadMedTradicionalUsecaseDB
        .saveUbicacionNombresMedTradicionalUsecaseDB(
            ubicacionId, state.lstNombreMedTradicional!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionTuberculosPlatanos(ubicacionId));
  }

  Future<void> saveUbicacionTuberculosPlatanos(int ubicacionId) async {
    final result = await tuberculoPlatanoUsecaseDB
        .saveUbicacionTuberculosPlatanosUsecaseDB(
            ubicacionId, state.lstTuberculos!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveUbicacionVerduras(ubicacionId));
  }

  Future<void> saveUbicacionVerduras(int ubicacionId) async {
    final result = await verduraUsecaseDB.saveUbicacionVerdurasUsecaseDB(
        ubicacionId, state.lstVerduras!);
    result.fold((failure) {
      add(DimUbicacionFormSubmissionFailed(failure.properties.first));
    }, (data) => add(DimUbicacionFormSubmissionSuccess(ubicacionId)));
  }
}
