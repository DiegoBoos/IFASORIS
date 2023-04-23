import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import 'package:ifasoris/domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import 'package:ifasoris/services/connection_sqlite_service.dart';

import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/usecases/afiliado/afiliado_exports.dart';
import '../../../domain/usecases/autoridad_indigena/autoridad_indigena_exports.dart';
import '../../../domain/usecases/cereal_by_dpto/cereal_by_dpto_exports.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/especie_animal_by_dpto/especie_animal_by_dpto_exports.dart';
import '../../../domain/usecases/estado_via/estado_via_exports.dart';
import '../../../domain/usecases/fruto_by_dpto/fruto_by_dpto_exports.dart';
import '../../../domain/usecases/hortaliza_by_dpto/hortaliza_by_dpto_exports.dart';
import '../../../domain/usecases/leguminosa_by_dpto/leguminosa_by_dpto_exports.dart';
import '../../../domain/usecases/medio_comunicacion/medio_comunicacion_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import '../../../domain/usecases/resguardo_by_dpto/resguardo_by_dpto_exports.dart';
import '../../../domain/usecases/sync_log/sync_log_exports.dart';
import '../../../domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';
import '../../../domain/usecases/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_exports.dart';
import '../../../domain/usecases/verdura_by_dpto/verdura_by_dpto_exports.dart';
import '../../../domain/usecases/via_acceso/via_acceso_exports.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final AfiliadoUsecase afiliadoUsecase;
  final AfiliadoUsecaseDB afiliadoUsecaseDB;
  final DificultadAccesoCAUsecase dificultadAccesoCAUsecase;
  final DificultadAccesoCAUsecaseDB dificultadAccesoCAUsecaseDB;
  final EstadoViaUsecase estadoViaUsecase;
  final EstadoViaUsecaseDB estadoViaUsecaseDB;
  final MedioComunicacionUsecase medioComunicacionUsecase;
  final MedioComunicacionUsecaseDB medioComunicacionUsecaseDB;
  final MedioUtilizaCAUsecase medioUtilizaCAUsecase;
  final MedioUtilizaCAUsecaseDB medioUtilizaCAUsecaseDB;
  final TiempoTardaCAUsecase tiempoTardaCAUsecase;
  final TiempoTardaCAUsecaseDB tiempoTardaCAUsecaseDB;
  final ViaAccesoUsecase viaAccesoUsecase;
  final ViaAccesoUsecaseDB viaAccesoUsecaseDB;
  final AutoridadIndigenaUsecase autoridadIndigenaUsecase;
  final AutoridadIndigenaUsecaseDB autoridadIndigenaUsecaseDB;
  final CerealByDptoUsecase cerealByDptoUsecase;
  final CerealByDptoUsecaseDB cerealByDptoUsecaseDB;
  final CostoDesplazamientoUsecase costoDesplazamientoUsecase;
  final CostoDesplazamientoUsecaseDB costoDesplazamientoUsecaseDB;
  final DificultadAccesoMedTradicionalByDptoUsecase
      dificultadAccesoMedTradicionalByDptoUsecase;
  final DificultadAccesoMedTradicionalByDptoUsecaseDB
      dificultadAccesoMedTradicionalByDptoUsecaseDB;
  final EspecialidadMedTradicionalByDptoUsecase
      especialidadMedTradicionalByDptoUsecase;
  final EspecialidadMedTradicionalByDptoUsecaseDB
      especialidadMedTradicionalByDptoUsecaseDB;
  final EspecieAnimalByDptoUsecase especieAnimalByDptoUsecase;
  final EspecieAnimalByDptoUsecaseDB especieAnimalByDptoUsecaseDB;
  final FrutoByDptoUsecase frutoByDptoUsecase;
  final FrutoByDptoUsecaseDB frutoByDptoUsecaseDB;
  final HortalizaByDptoUsecase hortalizaByDptoUsecase;
  final HortalizaByDptoUsecaseDB hortalizaByDptoUsecaseDB;
  final LeguminosaByDptoUsecase leguminosaByDptoUsecase;
  final LeguminosaByDptoUsecaseDB leguminosaByDptoUsecaseDB;
  final MedioUtilizaMedTradicionalByDptoUsecase
      medioUtilizaMedTradicionalByDptoUsecase;
  final MedioUtilizaMedTradicionalByDptoUsecaseDB
      medioUtilizaMedTradicionalByDptoUsecaseDB;
  final OpcionSiNoUsecase opcionSiNoUsecase;
  final OpcionSiNoUsecaseDB opcionSiNoUsecaseDB;
  final ResguardoByDptoUsecase resguardoByDptoUsecase;
  final ResguardoByDptoUsecaseDB resguardoByDptoUsecaseDB;
  final TiempoTardaMedTradicionalUsecase tiempoTardaMedTradicionalUsecase;
  final TiempoTardaMedTradicionalUsecaseDB tiempoTardaMedTradicionalUsecaseDB;
  final TuberculoPlatanoByDptoUsecase tuberculoPlatanoByDptoUsecase;
  final TuberculoPlatanoByDptoUsecaseDB tuberculoPlatanoByDptoUsecaseDB;
  final VerduraByDptoUsecase verduraByDptoUsecase;
  final VerduraByDptoUsecaseDB verduraByDptoUsecaseDB;

  final SyncLogUsecaseDB syncLogDB;

  List<AfiliadoEntity> afiliadosTemp = [];
  List<DificultadAccesoCAEntity> dificultadesAccesoCATemp = [];
  List<EstadoViaEntity> estadosViasTemp = [];
  List<MedioComunicacionEntity> mediosComunicacionTemp = [];
  List<MedioUtilizaCAEntity> mediosUtilizaCATemp = [];
  List<TiempoTardaCAEntity> tiemposTardaCATemp = [];
  List<ViaAccesoEntity> viasAccesoTemp = [];
  List<AutoridadIndigenaEntity> autoridadesIndigenasTemp = [];
  List<CerealEntity> cerealesByDptoTemp = [];
  List<CostoDesplazamientoEntity> costosDesplazamientoTemp = [];
  List<DificultadAccesoMedTradicionalEntity>
      dificultadesAccesoMedTradicionalByDptoTemp = [];
  List<EspecialidadMedTradicionalEntity>
      especialidadesMedTradicionalByDptoTemp = [];
  List<EspecieAnimalEntity> especiesAnimalesByDptoTemp = [];
  List<FrutoEntity> frutosByDptoTemp = [];
  List<HortalizaEntity> hortalizasByDptoTemp = [];
  List<LeguminosaEntity> leguminosasByDptoTemp = [];
  List<MedioUtilizaMedTradicionalEntity> mediosUtilizaMedTradicionalByDptoTemp =
      [];
  List<OpcionSiNoEntity> opcionesSiNoTemp = [];
  List<ResguardoEntity> resguardosByDptoTemp = [];
  List<TiempoTardaMedTradicionalEntity> tiemposTardaMedTradicionalTemp = [];
  List<TuberculoPlatanoEntity> tuberculosPlatanosByDptoTemp = [];
  List<VerduraEntity> verdurasByDptoTemp = [];

  SyncBloc({
    required this.afiliadoUsecase,
    required this.afiliadoUsecaseDB,
    required this.dificultadAccesoCAUsecase,
    required this.dificultadAccesoCAUsecaseDB,
    required this.estadoViaUsecase,
    required this.estadoViaUsecaseDB,
    required this.medioComunicacionUsecase,
    required this.medioComunicacionUsecaseDB,
    required this.medioUtilizaCAUsecase,
    required this.medioUtilizaCAUsecaseDB,
    required this.tiempoTardaCAUsecase,
    required this.tiempoTardaCAUsecaseDB,
    required this.viaAccesoUsecase,
    required this.viaAccesoUsecaseDB,
    required this.autoridadIndigenaUsecase,
    required this.autoridadIndigenaUsecaseDB,
    required this.cerealByDptoUsecase,
    required this.cerealByDptoUsecaseDB,
    required this.costoDesplazamientoUsecase,
    required this.costoDesplazamientoUsecaseDB,
    required this.dificultadAccesoMedTradicionalByDptoUsecase,
    required this.dificultadAccesoMedTradicionalByDptoUsecaseDB,
    required this.especialidadMedTradicionalByDptoUsecase,
    required this.especialidadMedTradicionalByDptoUsecaseDB,
    required this.especieAnimalByDptoUsecase,
    required this.especieAnimalByDptoUsecaseDB,
    required this.frutoByDptoUsecase,
    required this.frutoByDptoUsecaseDB,
    required this.hortalizaByDptoUsecase,
    required this.hortalizaByDptoUsecaseDB,
    required this.leguminosaByDptoUsecase,
    required this.leguminosaByDptoUsecaseDB,
    required this.medioUtilizaMedTradicionalByDptoUsecase,
    required this.medioUtilizaMedTradicionalByDptoUsecaseDB,
    required this.opcionSiNoUsecase,
    required this.opcionSiNoUsecaseDB,
    required this.resguardoByDptoUsecase,
    required this.resguardoByDptoUsecaseDB,
    required this.tiempoTardaMedTradicionalUsecase,
    required this.tiempoTardaMedTradicionalUsecaseDB,
    required this.tuberculoPlatanoByDptoUsecase,
    required this.tuberculoPlatanoByDptoUsecaseDB,
    required this.verduraByDptoUsecase,
    required this.verduraByDptoUsecaseDB,
    required this.syncLogDB,
  }) : super(SyncInitial()) {
    on<SyncStarted>((event, emit) async {
      if (event.tablesNames.contains('Afiliado')) {
        emit(InitializingSync());
        ConnectionSQLiteService.truncateTable('Afiliado').then((value) async {
          afiliadosTemp = [];
          await syncAfiliados(event, 1, 10);
        });
      } else if (event.tablesNames.contains('Accesorias')) {
        emit(InitializingSync());
        ConnectionSQLiteService.truncateTable(
                'DificultadesAcceso_CentroAtencion')
            .then((value) async {
          dificultadesAccesoCATemp = [];
          await syncDificultadesAccesoCA(event);
        });
      }
    });
    on<Downloading>((event, emit) => emit(SyncDownloading(event.syncProgress)));
    on<SyncStatusChanged>((event, emit) {
      event.syncProgress.counter == event.syncProgress.total
          ? emit(SyncSuccess())
          : emit(SyncInProgress(event.syncProgress));
    });
    on<SyncError>((event, emit) => emit(SyncFailure(event.message)));
    on<SyncLog>((event, emit) => emit(IncompleteSync(event.syncLog)));
  }

// ************************** Afiliados ****************************
  Future<void> syncAfiliados(
    SyncStarted event,
    int pagina,
    int registrosPorPagina,
  ) async {
    final result = await afiliadoUsecase.getAfiliadosUsecase(
        event.usuario.departamentoId!, pagina, registrosPorPagina);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      afiliadosTemp.addAll(data.resultado);
      add(Downloading(state.syncProgressModel.copyWith(
          title: 'Descargando afiliados',
          counter: afiliadosTemp.length,
          total: data.totalRegistros,
          percent: calculatePercent())));

      /* if ((afiliadosTemp.length <= data.totalRegistros) &&
          (pagina != data.totalPaginas)) {
        pagina++;
        await syncAfiliados(event, pagina, registrosPorPagina);
      } */
      await saveAfiliado(event, afiliadosTemp[0]);
    });
  }

  Future<void> saveAfiliado(
    SyncStarted event,
    AfiliadoEntity afiliado,
  ) async {
    final result = await afiliadoUsecaseDB.saveAfiliadoUsecaseDB(afiliado);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando afiliados',
          counter: data,
          total: afiliadosTemp.length,
          percent: calculatePercent())));

      if (data >= afiliadosTemp.length) {
        event.tablesNames.remove('Afiliado');
        add(SyncStarted(event.usuario, event.tablesNames));
        return;
      }

      AfiliadoEntity a = afiliadosTemp[data];

      await saveAfiliado(
        event,
        a,
      );
    });
  }
// ************************** Afiliados ****************************

// ************************** Dificultades acceso CA ****************************

  Future<void> syncDificultadesAccesoCA(SyncStarted event) async {
    final result =
        await dificultadAccesoCAUsecase.getDificultadesAccesoCAUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      dificultadesAccesoCATemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando dificultades acceso',
      )));

      await saveDificultadAccesoCA(
        event,
        dificultadesAccesoCATemp[0],
      );
    });
  }

  Future<void> saveDificultadAccesoCA(
    SyncStarted event,
    DificultadAccesoCAEntity dificultadAccesoCA,
  ) async {
    final result = await dificultadAccesoCAUsecaseDB
        .saveDificultadAccesoCAUsecase(dificultadAccesoCA);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando dificultades acceso centro atención',
          counter: data,
          total: dificultadesAccesoCATemp.length,
          percent: calculatePercent())));

      if (data >= dificultadesAccesoCATemp.length) {
        ConnectionSQLiteService.truncateTable('EstadoVias').then((value) async {
          estadosViasTemp = [];
          await syncEstadosVias(event);
        });
        return;
      }

      DificultadAccesoCAEntity d = dificultadesAccesoCATemp[data];

      await saveDificultadAccesoCA(
        event,
        d,
      );
    });
  }

// ************************** Dificultades acceso CA ****************************

// ************************** Estado Vias ****************************

  Future<void> syncEstadosVias(SyncStarted event) async {
    final result = await estadoViaUsecase.getEstadosViasUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      estadosViasTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando estados vías',
      )));

      await saveEstadoVia(
        event,
        estadosViasTemp[0],
      );
    });
  }

  Future<void> saveEstadoVia(
    SyncStarted event,
    EstadoViaEntity estadoVia,
  ) async {
    final result = await estadoViaUsecaseDB.saveEstadoViaUsecase(estadoVia);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando estados vias',
          counter: data,
          total: estadosViasTemp.length,
          percent: calculatePercent())));

      if (data >= estadosViasTemp.length) {
        ConnectionSQLiteService.truncateTable('MediosComunicacion')
            .then((value) async {
          mediosComunicacionTemp = [];
          await syncMediosComunicacion(event);
        });
        return;
      }

      EstadoViaEntity e = estadosViasTemp[data];

      await saveEstadoVia(
        event,
        e,
      );
    });
  }

// ************************** Estado Vias ****************************

// ************************** Medios comunicacion ****************************

  Future<void> syncMediosComunicacion(SyncStarted event) async {
    final result =
        await medioComunicacionUsecase.getMediosComunicacionUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      mediosComunicacionTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando medios comunicación',
      )));

      await saveMedioComunicacion(
        event,
        mediosComunicacionTemp[0],
      );
    });
  }

  Future<void> saveMedioComunicacion(
    SyncStarted event,
    MedioComunicacionEntity medioComunicacion,
  ) async {
    final result = await medioComunicacionUsecaseDB
        .saveMedioComunicacionUsecase(medioComunicacion);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios comunicación',
          counter: data,
          total: mediosComunicacionTemp.length,
          percent: calculatePercent())));

      if (data >= mediosComunicacionTemp.length) {
        ConnectionSQLiteService.truncateTable('MediosUtiliza_CentroAtencion')
            .then((value) async {
          mediosUtilizaCATemp = [];
          await syncMediosUtilizaCA(event);
        });
        return;
      }

      MedioComunicacionEntity m = mediosComunicacionTemp[data];

      await saveMedioComunicacion(
        event,
        m,
      );
    });
  }

// ************************** Medios comunicacion ****************************

// ************************** Medios utiliza CA ****************************

  Future<void> syncMediosUtilizaCA(SyncStarted event) async {
    final result = await medioUtilizaCAUsecase.getMediosUtilizaCAUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      mediosUtilizaCATemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando medios utiliza centro atención',
      )));

      await saveMedioUtilizaCA(
        event,
        mediosUtilizaCATemp[0],
      );
    });
  }

  Future<void> saveMedioUtilizaCA(
    SyncStarted event,
    MedioUtilizaCAEntity medioUtilizaCA,
  ) async {
    final result =
        await medioUtilizaCAUsecaseDB.saveMedioUtilizaCAUsecase(medioUtilizaCA);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios utiliza centro atención',
          counter: data,
          total: mediosUtilizaCATemp.length,
          percent: calculatePercent())));

      if (data >= mediosUtilizaCATemp.length) {
        ConnectionSQLiteService.truncateTable('TiemposTarda_CentroAtencion')
            .then((value) async {
          tiemposTardaCATemp = [];
          await syncTiemposTardaCA(event);
        });
        return;
      }

      MedioUtilizaCAEntity m = mediosUtilizaCATemp[data];

      await saveMedioUtilizaCA(
        event,
        m,
      );
    });
  }

// ************************** Medios utiliza CA ****************************

// ************************** Tiempos tarda CA ****************************

  Future<void> syncTiemposTardaCA(SyncStarted event) async {
    final result = await tiempoTardaCAUsecase.getTiemposTardaCAUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiemposTardaCATemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando medios utiliza centro atención',
      )));

      await saveTiemposTardaCA(
        event,
        tiemposTardaCATemp[0],
      );
    });
  }

  Future<void> saveTiemposTardaCA(
    SyncStarted event,
    TiempoTardaCAEntity tiempoTardaCA,
  ) async {
    final result =
        await tiempoTardaCAUsecaseDB.saveTiempoTardaCAUsecase(tiempoTardaCA);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tiempos tarda centro atención',
          counter: data,
          total: tiemposTardaCATemp.length,
          percent: calculatePercent())));

      if (data >= tiemposTardaCATemp.length) {
        ConnectionSQLiteService.truncateTable('ViasAcceso').then((value) async {
          viasAccesoTemp = [];
          await syncViasAcceso(event);
        });
        return;
      }

      TiempoTardaCAEntity t = tiemposTardaCATemp[data];

      await saveTiemposTardaCA(
        event,
        t,
      );
    });
  }

// ************************** Tiempos tarda CA ****************************

// ************************** Via acceso ****************************

  Future<void> syncViasAcceso(SyncStarted event) async {
    final result = await viaAccesoUsecase.getViasAccesoUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      viasAccesoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando vias acceso',
      )));

      await saveViaAcceso(
        event,
        viasAccesoTemp[0],
      );
    });
  }

  Future<void> saveViaAcceso(
    SyncStarted event,
    ViaAccesoEntity viaAcceso,
  ) async {
    final result = await viaAccesoUsecaseDB.saveViaAccesoUsecaseDB(viaAcceso);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando vias acceso',
          counter: data,
          total: viasAccesoTemp.length,
          percent: calculatePercent())));

      if (data >= viasAccesoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'AutoridadesIndigenas_DatosVivienda')
            .then((value) async {
          autoridadesIndigenasTemp = [];
          await syncAutoridadesIndigenas(event);
        });
        return;
      }

      ViaAccesoEntity v = viasAccesoTemp[data];

      await saveViaAcceso(
        event,
        v,
      );
    });
  }

// ************************** Via acceso ****************************

// ************************** AutoridadIndigena ****************************

  Future<void> syncAutoridadesIndigenas(SyncStarted event) async {
    final result =
        await autoridadIndigenaUsecase.getAutoridadesIndigenasUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      autoridadesIndigenasTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando autoridades indígenas',
      )));

      await saveAutoridadIndigena(
        event,
        autoridadesIndigenasTemp[0],
      );
    });
  }

  Future<void> saveAutoridadIndigena(
    SyncStarted event,
    AutoridadIndigenaEntity autoridadIndigena,
  ) async {
    final result = await autoridadIndigenaUsecaseDB
        .saveAutoridadIndigenaUsecaseDB(autoridadIndigena);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando autoridades indígenas',
          counter: data,
          total: autoridadesIndigenasTemp.length,
          percent: calculatePercent())));

      if (data >= autoridadesIndigenasTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'Cereales_AspectosSocioEconomicos')
            .then((value) async {
          cerealesByDptoTemp = [];
          await syncCerealesByDpto(event);
        });
        return;
      }

      AutoridadIndigenaEntity a = autoridadesIndigenasTemp[data];

      await saveAutoridadIndigena(
        event,
        a,
      );
    });
  }

// ************************** AutoridadIndigena ****************************

// ************************** CerealByDpto ****************************

  Future<void> syncCerealesByDpto(SyncStarted event) async {
    final result = await cerealByDptoUsecase
        .getCerealesByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      cerealesByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando cereales',
      )));

      await saveCerealByDpto(
        event,
        cerealesByDptoTemp[0],
      );
    });
  }

  Future<void> saveCerealByDpto(
    SyncStarted event,
    CerealEntity cereal,
  ) async {
    final result =
        await cerealByDptoUsecaseDB.saveCerealByDptoUsecaseDB(cereal);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando cereales',
          counter: data,
          total: cerealesByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= cerealesByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'CostosDesplazamiento_CentroAtencion')
            .then((value) async {
          costosDesplazamientoTemp = [];
          await syncCostosDesplazamiento(event);
        });
        return;
      }

      CerealEntity c = cerealesByDptoTemp[data];

      await saveCerealByDpto(
        event,
        c,
      );
    });
  }

// ************************** CerealByDpto ****************************

// ************************** CostoDesplazamiento ****************************

  Future<void> syncCostosDesplazamiento(SyncStarted event) async {
    final result =
        await costoDesplazamientoUsecase.getCostosDesplazamientoUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      costosDesplazamientoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando costos desplazamiento',
      )));

      await saveCostoDesplazamiento(
        event,
        costosDesplazamientoTemp[0],
      );
    });
  }

  Future<void> saveCostoDesplazamiento(
    SyncStarted event,
    CostoDesplazamientoEntity costoDesplazamiento,
  ) async {
    final result = await costoDesplazamientoUsecaseDB
        .saveCostoDesplazamientoUsecaseDB(costoDesplazamiento);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando costos desplazamiento',
          counter: data,
          total: costosDesplazamientoTemp.length,
          percent: calculatePercent())));

      if (data >= costosDesplazamientoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'DificultadesAcceso_AccesoMedTradicional')
            .then((value) async {
          dificultadesAccesoMedTradicionalByDptoTemp = [];
          await syncDificultadesAccesoMedTradicionalByDpto(event);
        });
        return;
      }

      CostoDesplazamientoEntity c = costosDesplazamientoTemp[data];

      await saveCostoDesplazamiento(
        event,
        c,
      );
    });
  }

// ************************** CostoDesplazamiento ****************************

// ************************** DificultadAccesoMedTradicionalByDpto ****************************

  Future<void> syncDificultadesAccesoMedTradicionalByDpto(
      SyncStarted event) async {
    final result = await dificultadAccesoMedTradicionalByDptoUsecase
        .getDificultadesAccesoMedTradicionalByDptoUsecase(
            event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      dificultadesAccesoMedTradicionalByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando dificultades acceso médico tradicional',
      )));

      await saveDificultadAccesoMedTradicionalByDpto(
        event,
        dificultadesAccesoMedTradicionalByDptoTemp[0],
      );
    });
  }

  Future<void> saveDificultadAccesoMedTradicionalByDpto(
    SyncStarted event,
    DificultadAccesoMedTradicionalEntity dificultadAccesoMedTradicional,
  ) async {
    final result = await dificultadAccesoMedTradicionalByDptoUsecaseDB
        .saveDificultadAccesoMedTradicionalByDptoUsecaseDB(
            dificultadAccesoMedTradicional);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando dificultades acceso médico tradicional',
          counter: data,
          total: dificultadesAccesoMedTradicionalByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= dificultadesAccesoMedTradicionalByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'EspecialidadesMedTrad_AccesoMedTradicional')
            .then((value) async {
          especialidadesMedTradicionalByDptoTemp = [];
          await syncEspecialidadesMedTradicionalByDpto(event);
        });
        return;
      }

      DificultadAccesoMedTradicionalEntity d =
          dificultadesAccesoMedTradicionalByDptoTemp[data];

      await saveDificultadAccesoMedTradicionalByDpto(
        event,
        d,
      );
    });
  }

// ************************** DificultadAccesoMedTradicionalByDpto ****************************

// ************************** EspecialidadMedTradicionalByDpto ****************************

  Future<void> syncEspecialidadesMedTradicionalByDpto(SyncStarted event) async {
    final result = await especialidadMedTradicionalByDptoUsecase
        .getEspecialidadesMedTradicionalByDptoUsecase(
            event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      especialidadesMedTradicionalByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando especialidades médico tradicional',
      )));

      await saveEspecialidadMedTradicionalByDpto(
        event,
        especialidadesMedTradicionalByDptoTemp[0],
      );
    });
  }

  Future<void> saveEspecialidadMedTradicionalByDpto(
    SyncStarted event,
    EspecialidadMedTradicionalEntity especialidadMedTradicional,
  ) async {
    final result = await especialidadMedTradicionalByDptoUsecaseDB
        .saveEspecialidadMedTradicionalByDptoUsecaseDB(
            especialidadMedTradicional);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando especialidades médico tradicional',
          counter: data,
          total: especialidadesMedTradicionalByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= especialidadesMedTradicionalByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'EspecieAnimalesCria_AspectosSocioEconomicos')
            .then((value) async {
          especiesAnimalesByDptoTemp = [];
          await syncEspeciesAnimalesByDpto(event);
        });
        return;
      }

      EspecialidadMedTradicionalEntity e =
          especialidadesMedTradicionalByDptoTemp[data];

      await saveEspecialidadMedTradicionalByDpto(
        event,
        e,
      );
    });
  }

// ************************** EspecialidadMedTradicionalByDpto ****************************

// ************************** EspecieAnimalByDpto ****************************

  Future<void> syncEspeciesAnimalesByDpto(SyncStarted event) async {
    final result = await especieAnimalByDptoUsecase
        .getEspeciesAnimalesByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      especiesAnimalesByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando especies animales',
      )));

      await saveEspecieAnimalByDpto(
        event,
        especiesAnimalesByDptoTemp[0],
      );
    });
  }

  Future<void> saveEspecieAnimalByDpto(
    SyncStarted event,
    EspecieAnimalEntity especieAnimal,
  ) async {
    final result = await especieAnimalByDptoUsecaseDB
        .saveEspecieAnimalByDptoUsecaseDB(especieAnimal);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando especies animales',
          counter: data,
          total: especiesAnimalesByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= especiesAnimalesByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable('Frutos_AspectosSocioEconomicos')
            .then((value) async {
          frutosByDptoTemp = [];
          await syncFrutosByDpto(event);
        });
        return;
      }

      EspecieAnimalEntity e = especiesAnimalesByDptoTemp[data];

      await saveEspecieAnimalByDpto(
        event,
        e,
      );
    });
  }

// ************************** EspecieAnimalByDpto ****************************

// ************************** FrutoByDpto ****************************

  Future<void> syncFrutosByDpto(SyncStarted event) async {
    final result = await frutoByDptoUsecase
        .getFrutosByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      frutosByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando frutos',
      )));

      await saveFrutoByDpto(
        event,
        frutosByDptoTemp[0],
      );
    });
  }

  Future<void> saveFrutoByDpto(
    SyncStarted event,
    FrutoEntity fruto,
  ) async {
    final result = await frutoByDptoUsecaseDB.saveFrutoByDptoUsecaseDB(fruto);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando frutos',
          counter: data,
          total: frutosByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= frutosByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'Hortalizas_AspectosSocioEconomicos')
            .then((value) async {
          hortalizasByDptoTemp = [];
          await syncHortalizasByDpto(event);
        });
        return;
      }

      FrutoEntity f = frutosByDptoTemp[data];

      await saveFrutoByDpto(
        event,
        f,
      );
    });
  }

// ************************** FrutoByDpto ****************************

// ************************** HortalizaByDpto ****************************

  Future<void> syncHortalizasByDpto(SyncStarted event) async {
    final result = await hortalizaByDptoUsecase
        .getHortalizasByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      hortalizasByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando hortalizas',
      )));

      await saveHortalizaByDpto(
        event,
        hortalizasByDptoTemp[0],
      );
    });
  }

  Future<void> saveHortalizaByDpto(
    SyncStarted event,
    HortalizaEntity hortaliza,
  ) async {
    final result =
        await hortalizaByDptoUsecaseDB.saveHortalizaByDptoUsecaseDB(hortaliza);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando hortalizas',
          counter: data,
          total: hortalizasByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= hortalizasByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'Leguminosas_AspectosSocioEconomicos')
            .then((value) async {
          leguminosasByDptoTemp = [];
          await syncLeguminosasByDpto(event);
        });
        return;
      }

      HortalizaEntity h = hortalizasByDptoTemp[data];

      await saveHortalizaByDpto(
        event,
        h,
      );
    });
  }

// ************************** HortalizaByDpto ****************************

// ************************** LeguminosaByDpto ****************************

  Future<void> syncLeguminosasByDpto(SyncStarted event) async {
    final result = await leguminosaByDptoUsecase
        .getLeguminosasByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      leguminosasByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando leguminosas',
      )));

      await saveLeguminosaByDpto(
        event,
        leguminosasByDptoTemp[0],
      );
    });
  }

  Future<void> saveLeguminosaByDpto(
    SyncStarted event,
    LeguminosaEntity leguminosa,
  ) async {
    final result = await leguminosaByDptoUsecaseDB
        .saveLeguminosaByDptoUsecaseDB(leguminosa);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando leguminosas',
          counter: data,
          total: leguminosasByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= leguminosasByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'MediosUtiliza_AccesoMedTradicional')
            .then((value) async {
          mediosUtilizaMedTradicionalByDptoTemp = [];
          await syncMediosUtilizaMedTradicionalByDpto(event);
        });
        return;
      }

      LeguminosaEntity l = leguminosasByDptoTemp[data];

      await saveLeguminosaByDpto(
        event,
        l,
      );
    });
  }

// ************************** LeguminosaByDpto ****************************

// ************************** MedioUtilizaMedTradicionalByDpto ****************************

  Future<void> syncMediosUtilizaMedTradicionalByDpto(SyncStarted event) async {
    final result = await medioUtilizaMedTradicionalByDptoUsecase
        .getMediosUtilizaMedTradicionalByDptoUsecase(
            event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      mediosUtilizaMedTradicionalByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando medios utiliza médico tradicional',
      )));

      await saveMedioUtilizaMedTradicionalByDpto(
        event,
        mediosUtilizaMedTradicionalByDptoTemp[0],
      );
    });
  }

  Future<void> saveMedioUtilizaMedTradicionalByDpto(
    SyncStarted event,
    MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicional,
  ) async {
    final result = await medioUtilizaMedTradicionalByDptoUsecaseDB
        .saveMedioUtilizaMedTradicionalByDptoUsecaseDB(
            medioUtilizaMedTradicional);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios utiliza médico tradicional',
          counter: data,
          total: mediosUtilizaMedTradicionalByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= mediosUtilizaMedTradicionalByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable('OpcionesSi_No')
            .then((value) async {
          opcionesSiNoTemp = [];
          await syncOpcionesSiNo(event);
        });
        return;
      }

      MedioUtilizaMedTradicionalEntity m =
          mediosUtilizaMedTradicionalByDptoTemp[data];

      await saveMedioUtilizaMedTradicionalByDpto(
        event,
        m,
      );
    });
  }

// ************************** MedioUtilizaMedTradicionalByDpto ****************************

// ************************** OpcionSiNo ****************************

  Future<void> syncOpcionesSiNo(SyncStarted event) async {
    final result = await opcionSiNoUsecase.getOpcionesSiNoUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      opcionesSiNoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando opciones',
      )));

      await saveOpcionSiNo(
        event,
        opcionesSiNoTemp[0],
      );
    });
  }

  Future<void> saveOpcionSiNo(
    SyncStarted event,
    OpcionSiNoEntity opcionSiNo,
  ) async {
    final result =
        await opcionSiNoUsecaseDB.saveOpcionSiNoUsecaseDB(opcionSiNo);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando opciones',
          counter: data,
          total: opcionesSiNoTemp.length,
          percent: calculatePercent())));

      if (data >= opcionesSiNoTemp.length) {
        ConnectionSQLiteService.truncateTable('Resguardos').then((value) async {
          resguardosByDptoTemp = [];
          await syncResguardosByDpto(event);
        });
        return;
      }

      OpcionSiNoEntity o = opcionesSiNoTemp[data];

      await saveOpcionSiNo(
        event,
        o,
      );
    });
  }

// ************************** OpcionSiNo ****************************

// ************************** ResguardoByDpto ****************************

  Future<void> syncResguardosByDpto(SyncStarted event) async {
    final result = await resguardoByDptoUsecase
        .getResguardosByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      resguardosByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando resguardos',
      )));

      await saveResguardoByDpto(
        event,
        resguardosByDptoTemp[0],
      );
    });
  }

  Future<void> saveResguardoByDpto(
    SyncStarted event,
    ResguardoEntity resguardo,
  ) async {
    final result =
        await resguardoByDptoUsecaseDB.saveResguardoByDptoUsecaseDB(resguardo);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando resguardos',
          counter: data,
          total: resguardosByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= resguardosByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TiemposTarda_AccesoMedTradicional')
            .then((value) async {
          tiemposTardaMedTradicionalTemp = [];
          await syncTiemposTardaMedTradicional(event);
        });
        return;
      }

      ResguardoEntity r = resguardosByDptoTemp[data];

      await saveResguardoByDpto(
        event,
        r,
      );
    });
  }

// ************************** ResguardoByDpto ****************************

// ************************** TiempoTardaMedTradicional ****************************

  Future<void> syncTiemposTardaMedTradicional(SyncStarted event) async {
    final result = await tiempoTardaMedTradicionalUsecase
        .getTiemposTardaMedTradicionalUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiemposTardaMedTradicionalTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando tiempos tarda médico tradicional',
      )));

      await saveTiempoTardaMedTradicional(
        event,
        tiemposTardaMedTradicionalTemp[0],
      );
    });
  }

  Future<void> saveTiempoTardaMedTradicional(
    SyncStarted event,
    TiempoTardaMedTradicionalEntity tiempoTardaMedTradicional,
  ) async {
    final result = await tiempoTardaMedTradicionalUsecaseDB
        .saveTiempoTardaMedTradicionalUsecaseDB(tiempoTardaMedTradicional);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tiempos tarda médico tradicional',
          counter: data,
          total: tiemposTardaMedTradicionalTemp.length,
          percent: calculatePercent())));

      if (data >= tiemposTardaMedTradicionalTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TuberculosPlatanos_AspectosSocioEconomicos')
            .then((value) async {
          tuberculosPlatanosByDptoTemp = [];
          await syncTuberculosPlatanosByDpto(event);
        });
        return;
      }

      TiempoTardaMedTradicionalEntity t = tiemposTardaMedTradicionalTemp[data];

      await saveTiempoTardaMedTradicional(
        event,
        t,
      );
    });
  }

// ************************** TiempoTardaMedTradicional ****************************

// ************************** TuberculoPlatanoByDpto ****************************

  Future<void> syncTuberculosPlatanosByDpto(SyncStarted event) async {
    final result = await tuberculoPlatanoByDptoUsecase
        .getTuberculosPlatanosByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tuberculosPlatanosByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando tubérculos plátanos',
      )));

      await saveTuberculoPlatanoByDpto(
        event,
        tuberculosPlatanosByDptoTemp[0],
      );
    });
  }

  Future<void> saveTuberculoPlatanoByDpto(
    SyncStarted event,
    TuberculoPlatanoEntity tuberculoPlatano,
  ) async {
    final result = await tuberculoPlatanoByDptoUsecaseDB
        .saveTuberculoPlatanoByDptoUsecaseDB(tuberculoPlatano);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tubérculos plátanos',
          counter: data,
          total: tuberculosPlatanosByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= tuberculosPlatanosByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'Verduras_AspectosSocioEconomicos')
            .then((value) async {
          tuberculosPlatanosByDptoTemp = [];
          await syncVerdurasByDpto(event);
        });
        return;
      }

      TuberculoPlatanoEntity t = tuberculosPlatanosByDptoTemp[data];

      await saveTuberculoPlatanoByDpto(
        event,
        t,
      );
    });
  }

// ************************** TuberculoPlatanoByDpto ****************************

// ************************** VerduraByDpto ****************************

  Future<void> syncVerdurasByDpto(SyncStarted event) async {
    final result = await verduraByDptoUsecase
        .getVerdurasByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      verdurasByDptoTemp.addAll(data);
      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando verduras',
      )));

      await saveVerduraByDpto(
        event,
        verdurasByDptoTemp[0],
      );
    });
  }

  Future<void> saveVerduraByDpto(
    SyncStarted event,
    VerduraEntity verdura,
  ) async {
    final result =
        await verduraByDptoUsecaseDB.saveVerduraByDptoUsecaseDB(verdura);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncStatusChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando verduras',
          counter: data,
          total: verdurasByDptoTemp.length,
          percent: calculatePercent())));

      if (data >= verdurasByDptoTemp.length) {
        event.tablesNames.remove('Accesorias');
        add(SyncStarted(event.usuario, event.tablesNames));
        return;
      }

      VerduraEntity v = verdurasByDptoTemp[data];

      await saveVerduraByDpto(
        event,
        v,
      );
    });
  }

// ************************** VerduraByDpto ****************************

  int calculatePercent() {
    final counter = state.syncProgressModel.counter <= 0
        ? 0.01
        : state.syncProgressModel.counter;
    final total =
        state.syncProgressModel.total <= 0 ? 1 : state.syncProgressModel.total;
    final percent = ((counter / total) * 100).toInt();

    return percent;
  }
}
