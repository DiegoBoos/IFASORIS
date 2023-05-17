import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import 'package:ifasoris/domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import 'package:ifasoris/domain/usecases/dim_ubicacion/dim_ubicacion_exports.dart';
import 'package:ifasoris/domain/usecases/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_exports.dart';
import 'package:ifasoris/services/connection_sqlite_service.dart';

import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/usecases/afiliado/afiliado_exports.dart';
import '../../../domain/usecases/autoridad_indigena/autoridad_indigena_exports.dart';
import '../../../domain/usecases/cereal_by_dpto/cereal_by_dpto_exports.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/dim_vivienda/dim_vivienda_exports.dart';
import '../../../domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/especie_animal_by_dpto/especie_animal_by_dpto_exports.dart';
import '../../../domain/usecases/estado_via/estado_via_exports.dart';
import '../../../domain/usecases/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/fruto_by_dpto/fruto_by_dpto_exports.dart';
import '../../../domain/usecases/hortaliza_by_dpto/hortaliza_by_dpto_exports.dart';
import '../../../domain/usecases/iluminacion_vivienda/iluminacion_vivienda_exports.dart';
import '../../../domain/usecases/leguminosa_by_dpto/leguminosa_by_dpto_exports.dart';
import '../../../domain/usecases/medio_comunicacion/medio_comunicacion_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import '../../../domain/usecases/piso_vivienda_by_dpto/piso_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/resguardo_by_dpto/resguardo_by_dpto_exports.dart';
import '../../../domain/usecases/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/sync_log/sync_log_exports.dart';
import '../../../domain/usecases/techo_vivienda_by_dpto/techo_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';
import '../../../domain/usecases/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_exports.dart';
import '../../../domain/usecases/ventilacion_vivienda/ventilacion_vivienda_exports.dart';
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
  final FactorRiesgoViviendaByDptoUsecase factorRiesgoViviendaByDptoUsecase;
  final FactorRiesgoViviendaByDptoUsecaseDB factorRiesgoViviendaByDptoUsecaseDB;
  final IluminacionViviendaUsecase iluminacionViviendaUsecase;
  final IluminacionViviendaUsecaseDB iluminacionViviendaUsecaseDB;
  final PisoViviendaByDptoUsecase pisoViviendaByDptoUsecase;
  final PisoViviendaByDptoUsecaseDB pisoViviendaByDptoUsecaseDB;
  final PresenciaAnimalViviendaByDptoUsecase
      presenciaAnimalViviendaByDptoUsecase;
  final PresenciaAnimalViviendaByDptoUsecaseDB
      presenciaAnimalViviendaByDptoUsecaseDB;
  final ServicioPublicoViviendaByDptoUsecase
      servicioPublicoViviendaByDptoUsecase;
  final ServicioPublicoViviendaByDptoUsecaseDB
      servicioPublicoViviendaByDptoUsecaseDB;
  final TechoViviendaByDptoUsecase techoViviendaByDptoUsecase;
  final TechoViviendaByDptoUsecaseDB techoViviendaByDptoUsecaseDB;
  final TenenciaViviendaByDptoUsecase tenenciaViviendaByDptoUsecase;
  final TenenciaViviendaByDptoUsecaseDB tenenciaViviendaByDptoUsecaseDB;
  final TipoCombustibleViviendaByDptoUsecase
      tipoCombustibleViviendaByDptoUsecase;
  final TipoCombustibleViviendaByDptoUsecaseDB
      tipoCombustibleViviendaByDptoUsecaseDB;
  final TipoSanitarioViviendaByDptoUsecase tipoSanitarioViviendaByDptoUsecase;
  final TipoSanitarioViviendaByDptoUsecaseDB
      tipoSanitarioViviendaByDptoUsecaseDB;
  final TratamientoAguaViviendaByDptoUsecase
      tratamientoAguaViviendaByDptoUsecase;
  final TratamientoAguaViviendaByDptoUsecaseDB
      tratamientoAguaViviendaByDptoUsecaseDB;
  final VentilacionViviendaUsecase ventilacionViviendaUsecase;
  final VentilacionViviendaUsecaseDB ventilacionViviendaUsecaseDB;

  final DimUbicacionUsecase dimUbicacionUsecase;
  final DimViviendaUsecase dimViviendaUsecase;

  final SyncLogUsecaseDB syncLogDB;

  int totalAccesories = 32;

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
  List<FactorRiesgoViviendaEntity> factoresRiesgoViviendaByDptoTemp = [];
  List<IluminacionViviendaEntity> iluminacionesViviendaTemp = [];
  List<PisoViviendaEntity> pisosViviendaByDptoTemp = [];
  List<PresenciaAnimalViviendaEntity> presenciaAnimalesViviendaByDptoTemp = [];
  List<ServicioPublicoViviendaEntity> serviciosPublicosViviendaByDptoTemp = [];
  List<TechoViviendaEntity> techosViviendaByDptoTemp = [];
  List<TenenciaViviendaEntity> tenenciasViviendaByDptoTemp = [];
  List<TipoCombustibleViviendaEntity> tiposCombustibleViviendaByDptoTemp = [];
  List<TipoSanitarioViviendaEntity> tiposSanitarioViviendaByDptoTemp = [];
  List<TratamientoAguaViviendaEntity> tratamientosAguaViviendaByDptoTemp = [];
  List<VentilacionViviendaEntity> ventilacionesViviendaTemp = [];

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
    required this.factorRiesgoViviendaByDptoUsecase,
    required this.factorRiesgoViviendaByDptoUsecaseDB,
    required this.iluminacionViviendaUsecase,
    required this.iluminacionViviendaUsecaseDB,
    required this.pisoViviendaByDptoUsecase,
    required this.pisoViviendaByDptoUsecaseDB,
    required this.presenciaAnimalViviendaByDptoUsecase,
    required this.presenciaAnimalViviendaByDptoUsecaseDB,
    required this.servicioPublicoViviendaByDptoUsecase,
    required this.servicioPublicoViviendaByDptoUsecaseDB,
    required this.techoViviendaByDptoUsecase,
    required this.techoViviendaByDptoUsecaseDB,
    required this.tenenciaViviendaByDptoUsecase,
    required this.tenenciaViviendaByDptoUsecaseDB,
    required this.tipoCombustibleViviendaByDptoUsecase,
    required this.tipoCombustibleViviendaByDptoUsecaseDB,
    required this.tipoSanitarioViviendaByDptoUsecase,
    required this.tipoSanitarioViviendaByDptoUsecaseDB,
    required this.tratamientoAguaViviendaByDptoUsecase,
    required this.tratamientoAguaViviendaByDptoUsecaseDB,
    required this.ventilacionViviendaUsecase,
    required this.ventilacionViviendaUsecaseDB,
    required this.dimUbicacionUsecase,
    required this.dimViviendaUsecase,
    required this.syncLogDB,
  }) : super(SyncInitial()) {
    on<SyncStarted>((event, emit) async {
      if (event.tablesNames.contains('Asp1_Ubicacion')) {
        emit(InitializingSync());
        ConnectionSQLiteService.truncateTable('Asp1_Ubicacion')
            .then((value) async {
          await syncDimUbicacion(event);
        });
      } else if (event.tablesNames.contains('Afiliado')) {
        emit(InitializingSync());
        ConnectionSQLiteService.truncateTable('Afiliado').then((value) async {
          afiliadosTemp = [];
          await syncAfiliados(event, 1, 10000);
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
    on<SyncAccesoriesChanged>((event, emit) {
      event.syncProgress.counter == event.syncProgress.total
          ? emit(SyncSuccess())
          : emit(SyncInProgressAccesories(event.syncProgress));
    });
    on<SyncError>((event, emit) => emit(SyncFailure(event.message)));
    on<SyncLog>((event, emit) => emit(IncompleteSync(event.syncLog)));
  }

// ************************** DimUbicacion ****************************
  Future<void> syncDimUbicacion(
    SyncStarted event,
  ) async {
    final result = await dimUbicacionUsecase.uploadDimUbicacionUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      print(data);
      /*  await syncDimVivienda(event); */
    });
  }
// ************************** DimUbicacion ****************************

// ************************** DimVivienda ****************************
  Future<void> syncDimVivienda(
    SyncStarted event,
  ) async {
    final result = await dimViviendaUsecase.uploadDimViviendaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) {
      event.tablesNames.remove('Asp1_Ubicacion');
      add(SyncStarted(event.usuario, event.tablesNames));
      return;
    });
  }
// ************************** DimVivienda ****************************

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando dificultades acceso',
          counter: 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando estados vías',
          counter: 2,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando medios comunicación',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando medios utiliza centro atención',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando medios utiliza centro atención',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando vias acceso',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando autoridades indígenas',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando cereales',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando costos desplazamiento',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando dificultades acceso médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando especialidades médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando especies animales',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando frutos',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando hortalizas',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando leguminosas',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando medios utiliza médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando opciones',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando resguardos',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando tiempos tarda médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando tubérculos plátanos',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      if (data >= tuberculosPlatanosByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'Verduras_AspectosSocioEconomicos')
            .then((value) async {
          verdurasByDptoTemp = [];
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
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando verduras',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

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
      if (data >= verdurasByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'FactoresRiesgoVivienda_DatosVivienda')
            .then((value) async {
          factoresRiesgoViviendaByDptoTemp = [];
          await syncFactoresRiesgoViviendaByDpto(event);
        });
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

// ************************** FactorRiesgoViviendaByDpto ****************************

  Future<void> syncFactoresRiesgoViviendaByDpto(SyncStarted event) async {
    final result = await factorRiesgoViviendaByDptoUsecase
        .getFactoresRiesgoViviendaByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      factoresRiesgoViviendaByDptoTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando factores riesgo vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveFactorRiesgoViviendaByDpto(
        event,
        factoresRiesgoViviendaByDptoTemp[0],
      );
    });
  }

  Future<void> saveFactorRiesgoViviendaByDpto(
    SyncStarted event,
    FactorRiesgoViviendaEntity factorRiesgoVivienda,
  ) async {
    final result = await factorRiesgoViviendaByDptoUsecaseDB
        .saveFactorRiesgoViviendaByDptoUsecaseDB(factorRiesgoVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= factoresRiesgoViviendaByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'IluminacionVivienda_DatosVivienda')
            .then((value) async {
          iluminacionesViviendaTemp = [];
          await syncIluminacionesVivienda(event);
        });
        return;
      }

      FactorRiesgoViviendaEntity f = factoresRiesgoViviendaByDptoTemp[data];

      await saveFactorRiesgoViviendaByDpto(
        event,
        f,
      );
    });
  }

// ************************** FactorRiesgoViviendaByDpto ****************************

// ************************** IluminacionVivienda ****************************

  Future<void> syncIluminacionesVivienda(SyncStarted event) async {
    final result =
        await iluminacionViviendaUsecase.getIluminacionesViviendaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      iluminacionesViviendaTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando iluminaciones vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveIluminacionVivienda(
        event,
        iluminacionesViviendaTemp[0],
      );
    });
  }

  Future<void> saveIluminacionVivienda(
    SyncStarted event,
    IluminacionViviendaEntity iluminacionVivienda,
  ) async {
    final result = await iluminacionViviendaUsecaseDB
        .saveIluminacionViviendaUsecaseDB(iluminacionVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= iluminacionesViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable('PisosVivienda_DatosVivienda')
            .then((value) async {
          pisosViviendaByDptoTemp = [];
          await syncPisosViviendaByDpto(event);
        });
        return;
      }

      IluminacionViviendaEntity i = iluminacionesViviendaTemp[data];

      await saveIluminacionVivienda(
        event,
        i,
      );
    });
  }

// ************************** IluminacionVivienda ****************************

// ************************** PisoViviendaByDpto ****************************

  Future<void> syncPisosViviendaByDpto(SyncStarted event) async {
    final result = await pisoViviendaByDptoUsecase
        .getPisosViviendaByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      pisosViviendaByDptoTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando pisos vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await savePisoViviendaByDpto(
        event,
        pisosViviendaByDptoTemp[0],
      );
    });
  }

  Future<void> savePisoViviendaByDpto(
    SyncStarted event,
    PisoViviendaEntity pisoVivienda,
  ) async {
    final result = await pisoViviendaByDptoUsecaseDB
        .savePisoViviendaByDptoUsecaseDB(pisoVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= pisosViviendaByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'PresenciaAnimalesVivienda_DatosVivienda')
            .then((value) async {
          presenciaAnimalesViviendaByDptoTemp = [];
          await syncPresenciaAnimalesViviendaByDpto(event);
        });
        return;
      }

      PisoViviendaEntity i = pisosViviendaByDptoTemp[data];

      await savePisoViviendaByDpto(
        event,
        i,
      );
    });
  }

// ************************** PisoViviendaByDpto ****************************

// ************************** PresenciaAnimalViviendaByDpto ****************************

  Future<void> syncPresenciaAnimalesViviendaByDpto(SyncStarted event) async {
    final result = await presenciaAnimalViviendaByDptoUsecase
        .getPresenciaAnimalesViviendaByDptoUsecase(
            event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      presenciaAnimalesViviendaByDptoTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando presencia animales',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await savePresenciaAnimalViviendaByDpto(
        event,
        presenciaAnimalesViviendaByDptoTemp[0],
      );
    });
  }

  Future<void> savePresenciaAnimalViviendaByDpto(
    SyncStarted event,
    PresenciaAnimalViviendaEntity presenciaAnimalVivienda,
  ) async {
    final result = await presenciaAnimalViviendaByDptoUsecaseDB
        .savePresenciaAnimalViviendaByDptoUsecaseDB(presenciaAnimalVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= presenciaAnimalesViviendaByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'ServiciosPublicosVivienda_DatosVivienda')
            .then((value) async {
          serviciosPublicosViviendaByDptoTemp = [];
          await syncServiciosPublicosViviendaByDpto(event);
        });
        return;
      }

      PresenciaAnimalViviendaEntity i =
          presenciaAnimalesViviendaByDptoTemp[data];

      await savePresenciaAnimalViviendaByDpto(
        event,
        i,
      );
    });
  }

// ************************** PresenciaAnimalViviendaByDpto ****************************

// ************************** ServicioPublicoViviendaByDpto ****************************

  Future<void> syncServiciosPublicosViviendaByDpto(SyncStarted event) async {
    final result = await servicioPublicoViviendaByDptoUsecase
        .getServiciosPublicosViviendaByDptoUsecase(
            event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      serviciosPublicosViviendaByDptoTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando servicios públicos',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveServicioPublicoViviendaByDpto(
        event,
        serviciosPublicosViviendaByDptoTemp[0],
      );
    });
  }

  Future<void> saveServicioPublicoViviendaByDpto(
    SyncStarted event,
    ServicioPublicoViviendaEntity servicioPublicoVivienda,
  ) async {
    final result = await servicioPublicoViviendaByDptoUsecaseDB
        .saveServicioPublicoViviendaByDptoUsecaseDB(servicioPublicoVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= serviciosPublicosViviendaByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable('TechosVivienda_DatosVivienda')
            .then((value) async {
          techosViviendaByDptoTemp = [];
          await syncTechosViviendaByDpto(event);
        });
        return;
      }

      ServicioPublicoViviendaEntity i =
          serviciosPublicosViviendaByDptoTemp[data];

      await saveServicioPublicoViviendaByDpto(
        event,
        i,
      );
    });
  }

// ************************** ServicioPublicoViviendaByDpto ****************************

// ************************** TechoViviendaByDpto ****************************

  Future<void> syncTechosViviendaByDpto(SyncStarted event) async {
    final result = await techoViviendaByDptoUsecase
        .getTechosViviendaByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      techosViviendaByDptoTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando techos vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveTechoViviendaByDpto(
        event,
        techosViviendaByDptoTemp[0],
      );
    });
  }

  Future<void> saveTechoViviendaByDpto(
    SyncStarted event,
    TechoViviendaEntity techoVivienda,
  ) async {
    final result = await techoViviendaByDptoUsecaseDB
        .saveTechoViviendaByDptoUsecaseDB(techoVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= techosViviendaByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable('TenenciasVivienda_DatosVivienda')
            .then((value) async {
          tenenciasViviendaByDptoTemp = [];
          await syncTenenciasViviendaByDpto(event);
        });
        return;
      }

      TechoViviendaEntity i = techosViviendaByDptoTemp[data];

      await saveTechoViviendaByDpto(
        event,
        i,
      );
    });
  }

// ************************** TechoViviendaByDpto ****************************

// ************************** TenenciaViviendaByDpto ****************************

  Future<void> syncTenenciasViviendaByDpto(SyncStarted event) async {
    final result = await tenenciaViviendaByDptoUsecase
        .getTenenciasViviendaByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tenenciasViviendaByDptoTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando tenencias vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveTenenciaViviendaByDpto(
        event,
        tenenciasViviendaByDptoTemp[0],
      );
    });
  }

  Future<void> saveTenenciaViviendaByDpto(
    SyncStarted event,
    TenenciaViviendaEntity tenenciaVivienda,
  ) async {
    final result = await tenenciaViviendaByDptoUsecaseDB
        .saveTenenciaViviendaByDptoUsecaseDB(tenenciaVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= tenenciasViviendaByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TiposCombustibleVivienda_DatosVivienda')
            .then((value) async {
          tiposCombustibleViviendaByDptoTemp = [];
          await syncTiposCombustibleViviendaByDpto(event);
        });
        return;
      }

      TenenciaViviendaEntity i = tenenciasViviendaByDptoTemp[data];

      await saveTenenciaViviendaByDpto(
        event,
        i,
      );
    });
  }

// ************************** TenenciaViviendaByDpto ****************************

// ************************** TipoCombustibleViviendaByDpto ****************************

  Future<void> syncTiposCombustibleViviendaByDpto(SyncStarted event) async {
    final result = await tipoCombustibleViviendaByDptoUsecase
        .getTiposCombustibleViviendaByDptoUsecase(
            event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiposCombustibleViviendaByDptoTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando tipos combustible vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveTipoCombustibleViviendaByDpto(
        event,
        tiposCombustibleViviendaByDptoTemp[0],
      );
    });
  }

  Future<void> saveTipoCombustibleViviendaByDpto(
    SyncStarted event,
    TipoCombustibleViviendaEntity tipoCombustibleVivienda,
  ) async {
    final result = await tipoCombustibleViviendaByDptoUsecaseDB
        .saveTipoCombustibleViviendaByDptoUsecaseDB(tipoCombustibleVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= tiposCombustibleViviendaByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TiposSanitarioVivienda_DatosVivienda')
            .then((value) async {
          tiposSanitarioViviendaByDptoTemp = [];
          await syncTiposSanitarioViviendaByDpto(event);
        });
        return;
      }

      TipoCombustibleViviendaEntity i =
          tiposCombustibleViviendaByDptoTemp[data];

      await saveTipoCombustibleViviendaByDpto(
        event,
        i,
      );
    });
  }

// ************************** TipoCombustibleViviendaByDpto ****************************

// ************************** TipoSanitarioViviendaByDpto ****************************

  Future<void> syncTiposSanitarioViviendaByDpto(SyncStarted event) async {
    final result = await tipoSanitarioViviendaByDptoUsecase
        .getTiposSanitarioViviendaByDptoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiposSanitarioViviendaByDptoTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando tipos sanitario vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveTipoSanitarioViviendaByDpto(
        event,
        tiposSanitarioViviendaByDptoTemp[0],
      );
    });
  }

  Future<void> saveTipoSanitarioViviendaByDpto(
    SyncStarted event,
    TipoSanitarioViviendaEntity tipoSanitarioVivienda,
  ) async {
    final result = await tipoSanitarioViviendaByDptoUsecaseDB
        .saveTipoSanitarioViviendaByDptoUsecaseDB(tipoSanitarioVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= tiposSanitarioViviendaByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TratamientoAguaVivienda_DatosVivienda')
            .then((value) async {
          tratamientosAguaViviendaByDptoTemp = [];
          await syncTratamientosAguaViviendaByDpto(event);
        });
        return;
      }

      TipoSanitarioViviendaEntity i = tiposSanitarioViviendaByDptoTemp[data];

      await saveTipoSanitarioViviendaByDpto(
        event,
        i,
      );
    });
  }

// ************************** TipoSanitarioViviendaByDpto ****************************

// ************************** TratamientoAguaViviendaByDpto ****************************

  Future<void> syncTratamientosAguaViviendaByDpto(SyncStarted event) async {
    final result = await tratamientoAguaViviendaByDptoUsecase
        .getTratamientosAguaViviendaByDptoUsecase(
            event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tratamientosAguaViviendaByDptoTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando tratamientos agua vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveTratamientoAguaViviendaByDpto(
        event,
        tratamientosAguaViviendaByDptoTemp[0],
      );
    });
  }

  Future<void> saveTratamientoAguaViviendaByDpto(
    SyncStarted event,
    TratamientoAguaViviendaEntity tratamientoAguaVivienda,
  ) async {
    final result = await tratamientoAguaViviendaByDptoUsecaseDB
        .saveTratamientoAguaViviendaByDptoUsecaseDB(tratamientoAguaVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= tratamientosAguaViviendaByDptoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'VentilacionVivienda_DatosVivienda')
            .then((value) async {
          ventilacionesViviendaTemp = [];
          await syncVentilacionesVivienda(event);
        });
        return;
      }

      TratamientoAguaViviendaEntity i =
          tratamientosAguaViviendaByDptoTemp[data];

      await saveTratamientoAguaViviendaByDpto(
        event,
        i,
      );
    });
  }

// ************************** TratamientoAguaViviendaByDpto ****************************

// ************************** VentilacionesVivienda ****************************

  Future<void> syncVentilacionesVivienda(SyncStarted event) async {
    final result =
        await ventilacionViviendaUsecase.getVentilacionesViviendaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      ventilacionesViviendaTemp.addAll(data);
      add(SyncAccesoriesChanged(state.syncProgressModel.copyWith(
          title: 'Descargando ventilaciones vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveVentilacionVivienda(
        event,
        ventilacionesViviendaTemp[0],
      );
    });
  }

  Future<void> saveVentilacionVivienda(
    SyncStarted event,
    VentilacionViviendaEntity ventilacionVivienda,
  ) async {
    final result = await ventilacionViviendaUsecaseDB
        .saveVentilacionViviendaUsecaseDB(ventilacionVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= ventilacionesViviendaTemp.length) {
        event.tablesNames.remove('Accesorias');
        add(SyncStarted(event.usuario, event.tablesNames));
        return;
      }

      VentilacionViviendaEntity i = ventilacionesViviendaTemp[data];

      await saveVentilacionVivienda(
        event,
        i,
      );
    });
  }

// ************************** VentilacionesVivienda ****************************

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
