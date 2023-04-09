import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import 'package:ifasoris/services/connection_sqlite_service.dart';

import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/usecases/afiliado/afiliado_exports.dart';
import '../../../domain/usecases/estado_via/estado_via_exports.dart';
import '../../../domain/usecases/medio_comunicacion/medio_comunicacion_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/sync_log/sync_log_exports.dart';
import '../../../domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
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

  final SyncLogUsecaseDB syncLogDB;

  List<AfiliadoEntity> afiliadosTemp = [];
  List<DificultadAccesoCAEntity> dificultadesAccesoCATemp = [];
  List<EstadoViaEntity> estadosViasTemp = [];
  List<MedioComunicacionEntity> mediosComunicacionTemp = [];
  List<MedioUtilizaCAEntity> mediosUtilizaCATemp = [];
  List<TiempoTardaCAEntity> tiemposTardaCATemp = [];
  List<ViaAccesoEntity> viasAccesoTemp = [];

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
    required this.syncLogDB,
  }) : super(SyncInitial()) {
    on<SyncStarted>((event, emit) async {
      if (event.tablesNames.contains('Afiliado')) {
        emit(InitializingSync());
        ConnectionSQLiteService.truncateTable('Afiliado').then((value) async {
          afiliadosTemp = [];
          await syncAfiliados(event, 1, 10000);
        });
      } else if (event.tablesNames.contains('Accesorias')) {
        emit(InitializingSync());
        await syncDificultadesAccesoCA(event);
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

      if ((afiliadosTemp.length <= data.totalRegistros) &&
          (pagina != data.totalPaginas)) {
        pagina++;
        await syncAfiliados(event, pagina, registrosPorPagina);
      }
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
          title: 'Descargando dificultades de acceso',
          counter: dificultadesAccesoCATemp.length,
          total: data.length,
          percent: calculatePercent())));

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
          title: 'Sincronizando dificultades de acceso',
          counter: state.syncProgressModel.counter + 1,
          percent: calculatePercent())));

      if (data >= dificultadesAccesoCATemp.length) {
        syncEstadosVias(event);
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
          counter: estadosViasTemp.length,
          total: data.length,
          percent: calculatePercent())));

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
          counter: state.syncProgressModel.counter + 1,
          percent: calculatePercent())));

      if (data >= estadosViasTemp.length) {
        await syncMediosComunicacion(event);
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
          counter: mediosComunicacionTemp.length,
          total: data.length,
          percent: calculatePercent())));

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
          counter: state.syncProgressModel.counter + 1,
          percent: calculatePercent())));

      if (data >= mediosComunicacionTemp.length) {
        await syncMediosUtilizaCA(event);
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
          title: 'Descargando medios utiliza centro de atención',
          counter: mediosUtilizaCATemp.length,
          total: data.length,
          percent: calculatePercent())));

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
          title: 'Sincronizando medios utiliza centro de atención',
          counter: state.syncProgressModel.counter + 1,
          percent: calculatePercent())));

      if (data >= mediosUtilizaCATemp.length) {
        await syncTiemposTardaCA(event);

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
          title: 'Descargando medios utiliza centro de atención',
          counter: tiemposTardaCATemp.length,
          total: data.length,
          percent: calculatePercent())));

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
          title: 'Sincronizando tiempos tarda centro de atención',
          counter: state.syncProgressModel.counter + 1,
          percent: calculatePercent())));

      if (data >= tiemposTardaCATemp.length) {
        await syncViasAcceso(event);
        return;
      }

      TiempoTardaCAEntity m = tiemposTardaCATemp[data];

      await saveTiemposTardaCA(
        event,
        m,
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
          counter: viasAccesoTemp.length,
          total: data.length,
          percent: calculatePercent())));

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
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.counter + 1,
          percent: calculatePercent())));

      if (data >= viasAccesoTemp.length) {
        event.tablesNames.remove('Accesorias');
        add(SyncStarted(event.usuario, event.tablesNames));
        return;
      }

      ViaAccesoEntity m = viasAccesoTemp[data];

      await saveViaAcceso(
        event,
        m,
      );
    });
  }

// ************************** Via acceso ****************************

  Future<void> verifySync() async {
    final result = await syncLogDB.getSyncLogsUsecaseDB();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) {
      if (data!.isNotEmpty) {
        add(SyncLog(data));
      } else {
        add(SyncStatusChanged(state.syncProgressModel.copyWith(
            title: 'Sincronización Completada',
            counter: state.syncProgressModel.counter + 1,
            percent: calculatePercent())));
      }
    });
  }

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
