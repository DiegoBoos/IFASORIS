import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';

import 'domain/usecases/afiliado/afiliado_exports.dart';
import 'domain/usecases/auth/auth_exports.dart';
import 'domain/usecases/autoridad_indigena/autoridad_indigena_exports.dart';
import 'domain/usecases/cereal_by_dpto/cereal_by_dpto_exports.dart';
import 'domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import 'domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import 'domain/usecases/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_exports.dart';
import 'domain/usecases/dim_ubicacion/dim_ubicacion_exports.dart';
import 'domain/usecases/dim_vivienda/dim_vivienda_exports.dart';
import 'domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_exports.dart';
import 'domain/usecases/especie_animal_by_dpto/especie_animal_by_dpto_exports.dart';
import 'domain/usecases/estado_via/estado_via_exports.dart';
import 'domain/usecases/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_exports.dart';
import 'domain/usecases/familia/familia_exports.dart';
import 'domain/usecases/ficha/ficha_exports.dart';
import 'domain/usecases/fruto_by_dpto/fruto_by_dpto_exports.dart';
import 'domain/usecases/hortaliza_by_dpto/hortaliza_by_dpto_exports.dart';
import 'domain/usecases/iluminacion_vivienda/iluminacion_vivienda_exports.dart';
import 'domain/usecases/leguminosa_by_dpto/leguminosa_by_dpto_exports.dart';
import 'domain/usecases/medio_comunicacion/medio_comunicacion_exports.dart';
import 'domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import 'domain/usecases/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_exports.dart';
import 'domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import 'domain/usecases/piso_vivienda_by_dpto/piso_vivienda_by_dpto_exports.dart';
import 'domain/usecases/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_exports.dart';
import 'domain/usecases/resguardo_by_dpto/resguardo_by_dpto_exports.dart';
import 'domain/usecases/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_exports.dart';
import 'domain/usecases/sync_log/sync_log_exports.dart';
import 'domain/usecases/techo_vivienda_by_dpto/techo_vivienda_by_dpto_exports.dart';
import 'domain/usecases/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_exports.dart';
import 'domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import 'domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';
import 'domain/usecases/tipo_calendario/tipo_calendario_exports.dart';
import 'domain/usecases/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_exports.dart';
import 'domain/usecases/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_exports.dart';
import 'domain/usecases/tipo_vivienda_by_dpto/tipo_vivienda_by_dpto_exports.dart';
import 'domain/usecases/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_exports.dart';
import 'domain/usecases/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_exports.dart';
import 'domain/usecases/ventilacion_vivienda/ventilacion_vivienda_exports.dart';
import 'domain/usecases/verdura_by_dpto/verdura_by_dpto_exports.dart';
import 'domain/usecases/via_acceso/via_acceso_exports.dart';
import 'ui/blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import 'ui/blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import 'ui/blocs/grupo_familiar/grupo_familiar_bloc.dart';
import 'ui/blocs/sync/sync_bloc.dart';
import 'ui/cubits/internet/internet_cubit.dart';

final locator = GetIt.instance;

void init() {
  authInit();
  internetInit();
  syncInit();
  syncLogInit();
  afiliadoInit();
  afiliadoPrefsInit();
  dificultadAccesoCAInit();
  estadoViaInit();
  medioComunicacionInit();
  medioUtilizaCAInit();
  tiempoTardaCAInit();
  viaAccesoInit();
  autoridadIndigenaInit();
  cerealByDptoInit();
  costoDesplazamientoInit();
  dificultadAccesoMedTradicionalByDptoInit();
  especialidadMedTradicionalByDptoInit();
  especieAnimalByDptoInit();
  frutoByDptoInit();
  hortalizaByDptoInit();
  leguminosaByDptoInit();
  medioUtilizaMedTradicionalByDptoInit();
  opcionSiNoInit();
  resguardoInit();
  tiempoTardaMedTradicionalInit();
  tuberculoPlatanoByDptoInit();
  verduraByDptoInit();
  factorRiesgoViviendaByDptoInit();
  iluminacionViviendaInit();
  pisoViviendaByDptoInit();
  presenciaAnimalViviendaByDptoInit();
  servicioPublicoViviendaByDptoInit();
  techoViviendaByDptoInit();
  tenenciaViviendaByDptoInit();
  tipoCombustibleViviendaByDptoInit();
  tipoSanitarioViviendaByDptoInit();
  tipoViviendaByDptoInit();
  tratamientoAguaViviendaByDptoInit();
  ventilacionViviendaByDptoInit();
  tipoCalendarioInit();
  fichaInit();
  familiaInit();
  dimUbicacionInit();
  dimViviendaInit();
  grupoFamiliarInit();
  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => SharedPreferencesService());
}

void authInit() {
  // bloc
  locator.registerFactory(() => AuthBloc(
        auth: locator(),
        authDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => AuthUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => AuthUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AuthRepositoryDB>(
    () => AuthRepositoryDBImpl(
      authLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
}

void internetInit() {
  // cubit
  locator.registerFactory(() => InternetCubit());
}

void syncInit() {
  // bloc
  locator.registerFactory(() => SyncBloc(
        syncLogDB: locator(),
        afiliadoUsecase: locator(),
        afiliadoUsecaseDB: locator(),
        dificultadAccesoCAUsecase: locator(),
        dificultadAccesoCAUsecaseDB: locator(),
        estadoViaUsecase: locator(),
        estadoViaUsecaseDB: locator(),
        medioComunicacionUsecase: locator(),
        medioComunicacionUsecaseDB: locator(),
        medioUtilizaCAUsecase: locator(),
        medioUtilizaCAUsecaseDB: locator(),
        tiempoTardaCAUsecase: locator(),
        tiempoTardaCAUsecaseDB: locator(),
        viaAccesoUsecase: locator(),
        viaAccesoUsecaseDB: locator(),
        autoridadIndigenaUsecase: locator(),
        autoridadIndigenaUsecaseDB: locator(),
        cerealByDptoUsecase: locator(),
        cerealByDptoUsecaseDB: locator(),
        costoDesplazamientoUsecase: locator(),
        costoDesplazamientoUsecaseDB: locator(),
        dificultadAccesoMedTradicionalByDptoUsecase: locator(),
        dificultadAccesoMedTradicionalByDptoUsecaseDB: locator(),
        especialidadMedTradicionalByDptoUsecase: locator(),
        especialidadMedTradicionalByDptoUsecaseDB: locator(),
        especieAnimalByDptoUsecase: locator(),
        especieAnimalByDptoUsecaseDB: locator(),
        frutoByDptoUsecase: locator(),
        frutoByDptoUsecaseDB: locator(),
        hortalizaByDptoUsecase: locator(),
        hortalizaByDptoUsecaseDB: locator(),
        leguminosaByDptoUsecase: locator(),
        leguminosaByDptoUsecaseDB: locator(),
        medioUtilizaMedTradicionalByDptoUsecase: locator(),
        medioUtilizaMedTradicionalByDptoUsecaseDB: locator(),
        opcionSiNoUsecase: locator(),
        opcionSiNoUsecaseDB: locator(),
        resguardoByDptoUsecase: locator(),
        resguardoByDptoUsecaseDB: locator(),
        tiempoTardaMedTradicionalUsecase: locator(),
        tiempoTardaMedTradicionalUsecaseDB: locator(),
        tuberculoPlatanoByDptoUsecase: locator(),
        tuberculoPlatanoByDptoUsecaseDB: locator(),
        verduraByDptoUsecase: locator(),
        verduraByDptoUsecaseDB: locator(),
        factorRiesgoViviendaByDptoUsecase: locator(),
        factorRiesgoViviendaByDptoUsecaseDB: locator(),
        iluminacionViviendaUsecase: locator(),
        iluminacionViviendaUsecaseDB: locator(),
        pisoViviendaByDptoUsecase: locator(),
        pisoViviendaByDptoUsecaseDB: locator(),
        presenciaAnimalViviendaByDptoUsecase: locator(),
        presenciaAnimalViviendaByDptoUsecaseDB: locator(),
        servicioPublicoViviendaByDptoUsecase: locator(),
        servicioPublicoViviendaByDptoUsecaseDB: locator(),
        techoViviendaByDptoUsecase: locator(),
        techoViviendaByDptoUsecaseDB: locator(),
        tenenciaViviendaByDptoUsecase: locator(),
        tenenciaViviendaByDptoUsecaseDB: locator(),
        tipoCombustibleViviendaByDptoUsecase: locator(),
        tipoCombustibleViviendaByDptoUsecaseDB: locator(),
        tipoSanitarioViviendaByDptoUsecase: locator(),
        tipoSanitarioViviendaByDptoUsecaseDB: locator(),
        tratamientoAguaViviendaByDptoUsecase: locator(),
        tratamientoAguaViviendaByDptoUsecaseDB: locator(),
        ventilacionViviendaUsecase: locator(),
        ventilacionViviendaUsecaseDB: locator(),
        tipoViviendaByDptoUsecase: locator(),
        tipoViviendaByDptoUsecaseDB: locator(),
        dimUbicacionUsecase: locator(),
        dimViviendaUsecase: locator(),
        tipoCalendarioUsecase: locator(),
        tipoCalendarioUsecaseDB: locator(),
      ));
}

void syncLogInit() {
  // cubit
  locator.registerFactory(() => SyncLogCubit(syncLogDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => SyncLogUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<SyncLogRepositoryDB>(
    () => SyncLogRepositoryDBImpl(
      syncLogLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<SyncLogLocalDataSource>(
    () => SyncLogLocalDataSourceImpl(),
  );
}

void afiliadoInit() {
  // bloc
  locator.registerFactory(() => AfiliadoBloc(afiliadoUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => AfiliadoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => AfiliadoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AfiliadoRepository>(
    () => AfiliadoRepositoryImpl(
      afiliadoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AfiliadoRepositoryDB>(
    () => AfiliadoRepositoryDBImpl(
      afiliadoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AfiliadoRemoteDataSource>(
    () => AfiliadoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AfiliadoLocalDataSource>(
    () => AfiliadoLocalDataSourceImpl(),
  );
}

void afiliadoPrefsInit() {
  // bloc
  locator.registerFactory(
      () => AfiliadoPrefsBloc(sharedPreferencesService: locator()));
}

void dificultadAccesoCAInit() {
  // cubit
  locator.registerFactory(
      () => DificultadAccesoCACubit(dificultadAccesoCAUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => DificultadAccesoCAUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => DificultadAccesoCAUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<DificultadAccesoCARepository>(
    () => DificultadAccesoCARepositoryImpl(
      dificultadAccesoCARemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<DificultadAccesoCARepositoryDB>(
    () => DificultadAccesoCARepositoryDBImpl(
      dificultadAccesoCALocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<DificultadAccesoCARemoteDataSource>(
    () => DificultadAccesoCARemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<DificultadAccesoCALocalDataSource>(
    () => DificultadAccesoCALocalDataSourceImpl(),
  );
}

void estadoViaInit() {
  // cubit
  locator.registerFactory(() => EstadoViaCubit(estadoViaUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => EstadoViaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => EstadoViaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EstadoViaRepository>(
    () => EstadoViaRepositoryImpl(
      estadoViaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EstadoViaRepositoryDB>(
    () => EstadoViaRepositoryDBImpl(
      estadoViaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EstadoViaRemoteDataSource>(
    () => EstadoViaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EstadoViaLocalDataSource>(
    () => EstadoViaLocalDataSourceImpl(),
  );
}

void medioComunicacionInit() {
  // cubit
  locator.registerFactory(
      () => MedioComunicacionCubit(medioComunicacionUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => MedioComunicacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => MedioComunicacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<MedioComunicacionRepository>(
    () => MedioComunicacionRepositoryImpl(
      medioComunicacionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<MedioComunicacionRepositoryDB>(
    () => MedioComunicacionRepositoryDBImpl(
      medioComunicacionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<MedioComunicacionRemoteDataSource>(
    () => MedioComunicacionRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<MedioComunicacionLocalDataSource>(
    () => MedioComunicacionLocalDataSourceImpl(),
  );
}

void medioUtilizaCAInit() {
  // cubit
  locator.registerFactory(
      () => MedioUtilizaCACubit(medioUtilizaCAUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => MedioUtilizaCAUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => MedioUtilizaCAUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<MedioUtilizaCARepository>(
    () => MedioUtilizaCARepositoryImpl(
      medioUtilizaCARemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<MedioUtilizaCARepositoryDB>(
    () => MedioUtilizaCARepositoryDBImpl(
      medioUtilizaCALocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<MedioUtilizaCARemoteDataSource>(
    () => MedioUtilizaCARemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<MedioUtilizaCALocalDataSource>(
    () => MedioUtilizaCALocalDataSourceImpl(),
  );
}

void tiempoTardaCAInit() {
  // cubit
  locator.registerFactory(
      () => TiempoTardaCACubit(tiempoTardaCAUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => TiempoTardaCAUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TiempoTardaCAUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TiempoTardaCARepository>(
    () => TiempoTardaCARepositoryImpl(
      tiempoTardaCARemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TiempoTardaCARepositoryDB>(
    () => TiempoTardaCARepositoryDBImpl(
      tiempoTardaCALocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TiempoTardaCARemoteDataSource>(
    () => TiempoTardaCARemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TiempoTardaCALocalDataSource>(
    () => TiempoTardaCALocalDataSourceImpl(),
  );
}

void viaAccesoInit() {
  // cubit
  locator.registerFactory(() => ViaAccesoCubit(
        viaAccesoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => ViaAccesoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ViaAccesoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ViaAccesoRepository>(
    () => ViaAccesoRepositoryImpl(
      viaAccesoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ViaAccesoRepositoryDB>(
    () => ViaAccesoRepositoryDBImpl(
      viaAccesoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ViaAccesoRemoteDataSource>(
    () => ViaAccesoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ViaAccesoLocalDataSource>(
    () => ViaAccesoLocalDataSourceImpl(),
  );
}

void autoridadIndigenaInit() {
  // cubit
  locator.registerFactory(() => AutoridadIndigenaCubit(
        autoridadIndigenaUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => AutoridadIndigenaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => AutoridadIndigenaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AutoridadIndigenaRepository>(
    () => AutoridadIndigenaRepositoryImpl(
      autoridadIndigenaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AutoridadIndigenaRepositoryDB>(
    () => AutoridadIndigenaRepositoryDBImpl(
      autoridadIndigenaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AutoridadIndigenaRemoteDataSource>(
    () => AutoridadIndigenaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AutoridadIndigenaLocalDataSource>(
    () => AutoridadIndigenaLocalDataSourceImpl(),
  );
}

void cerealByDptoInit() {
  // cubit
  locator.registerFactory(() => CerealByDptoCubit(
        cerealByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => CerealByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => CerealByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<CerealByDptoRepository>(
    () => CerealByDptoRepositoryImpl(
      cerealByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<CerealByDptoRepositoryDB>(
    () => CerealByDptoRepositoryDBImpl(
      cerealByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<CerealByDptoRemoteDataSource>(
    () => CerealByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CerealByDptoLocalDataSource>(
    () => CerealByDptoLocalDataSourceImpl(),
  );
}

void costoDesplazamientoInit() {
  // cubit
  locator.registerFactory(() => CostoDesplazamientoCubit(
        costoDesplazamientoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => CostoDesplazamientoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => CostoDesplazamientoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<CostoDesplazamientoRepository>(
    () => CostoDesplazamientoRepositoryImpl(
      costoDesplazamientoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<CostoDesplazamientoRepositoryDB>(
    () => CostoDesplazamientoRepositoryDBImpl(
      costoDesplazamientoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<CostoDesplazamientoRemoteDataSource>(
    () => CostoDesplazamientoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CostoDesplazamientoLocalDataSource>(
    () => CostoDesplazamientoLocalDataSourceImpl(),
  );
}

void dificultadAccesoMedTradicionalByDptoInit() {
  // cubit
  locator.registerFactory(() => DificultadAccesoMedTradicionalByDptoCubit(
        dificultadAccesoMedTradicionalByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(
      () => DificultadAccesoMedTradicionalByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => DificultadAccesoMedTradicionalByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<DificultadAccesoMedTradicionalByDptoRepository>(
    () => DificultadAccesoMedTradicionalByDptoRepositoryImpl(
      dificultadAccesoMedTradicionalByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator
      .registerLazySingleton<DificultadAccesoMedTradicionalByDptoRepositoryDB>(
    () => DificultadAccesoMedTradicionalByDptoRepositoryDBImpl(
      dificultadAccesoMedTradicionalByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<
      DificultadAccesoMedTradicionalByDptoRemoteDataSource>(
    () => DificultadAccesoMedTradicionalByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<
      DificultadAccesoMedTradicionalByDptoLocalDataSource>(
    () => DificultadAccesoMedTradicionalByDptoLocalDataSourceImpl(),
  );
}

void especialidadMedTradicionalByDptoInit() {
  // cubit
  locator.registerFactory(() => EspecialidadMedTradicionalByDptoCubit(
        especialidadMedTradicionalByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(
      () => EspecialidadMedTradicionalByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => EspecialidadMedTradicionalByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EspecialidadMedTradicionalByDptoRepository>(
    () => EspecialidadMedTradicionalByDptoRepositoryImpl(
      especialidadMedTradicionalByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EspecialidadMedTradicionalByDptoRepositoryDB>(
    () => EspecialidadMedTradicionalByDptoRepositoryDBImpl(
      especialidadMedTradicionalByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator
      .registerLazySingleton<EspecialidadMedTradicionalByDptoRemoteDataSource>(
    () => EspecialidadMedTradicionalByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator
      .registerLazySingleton<EspecialidadMedTradicionalByDptoLocalDataSource>(
    () => EspecialidadMedTradicionalByDptoLocalDataSourceImpl(),
  );
}

void especieAnimalByDptoInit() {
  // cubit
  locator.registerFactory(() => EspecieAnimalByDptoCubit(
        especieAnimalByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => EspecieAnimalByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => EspecieAnimalByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EspecieAnimalByDptoRepository>(
    () => EspecieAnimalByDptoRepositoryImpl(
      especieAnimalByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EspecieAnimalByDptoRepositoryDB>(
    () => EspecieAnimalByDptoRepositoryDBImpl(
      especieAnimalByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EspecieAnimalByDptoRemoteDataSource>(
    () => EspecieAnimalByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EspecieAnimalByDptoLocalDataSource>(
    () => EspecieAnimalByDptoLocalDataSourceImpl(),
  );
}

void frutoByDptoInit() {
  // cubit
  locator.registerFactory(() => FrutoByDptoCubit(
        frutoByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => FrutoByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => FrutoByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<FrutoByDptoRepository>(
    () => FrutoByDptoRepositoryImpl(
      frutoByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<FrutoByDptoRepositoryDB>(
    () => FrutoByDptoRepositoryDBImpl(
      frutoByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<FrutoByDptoRemoteDataSource>(
    () => FrutoByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<FrutoByDptoLocalDataSource>(
    () => FrutoByDptoLocalDataSourceImpl(),
  );
}

void hortalizaByDptoInit() {
  // cubit
  locator.registerFactory(() => HortalizaByDptoCubit(
        hortalizaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => HortalizaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => HortalizaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<HortalizaByDptoRepository>(
    () => HortalizaByDptoRepositoryImpl(
      hortalizaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<HortalizaByDptoRepositoryDB>(
    () => HortalizaByDptoRepositoryDBImpl(
      hortalizaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<HortalizaByDptoRemoteDataSource>(
    () => HortalizaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<HortalizaByDptoLocalDataSource>(
    () => HortalizaByDptoLocalDataSourceImpl(),
  );
}

void leguminosaByDptoInit() {
  // cubit
  locator.registerFactory(() => LeguminosaByDptoCubit(
        leguminosaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => LeguminosaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => LeguminosaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<LeguminosaByDptoRepository>(
    () => LeguminosaByDptoRepositoryImpl(
      leguminosaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<LeguminosaByDptoRepositoryDB>(
    () => LeguminosaByDptoRepositoryDBImpl(
      leguminosaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<LeguminosaByDptoRemoteDataSource>(
    () => LeguminosaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<LeguminosaByDptoLocalDataSource>(
    () => LeguminosaByDptoLocalDataSourceImpl(),
  );
}

void medioUtilizaMedTradicionalByDptoInit() {
  // cubit
  locator.registerFactory(() => MedioUtilizaMedTradicionalByDptoCubit(
        medioUtilizaMedTradicionalByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(
      () => MedioUtilizaMedTradicionalByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => MedioUtilizaMedTradicionalByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<MedioUtilizaMedTradicionalByDptoRepository>(
    () => MedioUtilizaMedTradicionalByDptoRepositoryImpl(
      medioUtilizaMedTradicionalByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<MedioUtilizaMedTradicionalByDptoRepositoryDB>(
    () => MedioUtilizaMedTradicionalByDptoRepositoryDBImpl(
      medioUtilizaMedTradicionalByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator
      .registerLazySingleton<MedioUtilizaMedTradicionalByDptoRemoteDataSource>(
    () => MedioUtilizaMedTradicionalByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator
      .registerLazySingleton<MedioUtilizaMedTradicionalByDptoLocalDataSource>(
    () => MedioUtilizaMedTradicionalByDptoLocalDataSourceImpl(),
  );
}

void opcionSiNoInit() {
  // cubit
  locator.registerFactory(() => OpcionSiNoCubit(
        opcionSiNoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => OpcionSiNoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => OpcionSiNoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<OpcionSiNoRepository>(
    () => OpcionSiNoRepositoryImpl(
      opcionSiNoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<OpcionSiNoRepositoryDB>(
    () => OpcionSiNoRepositoryDBImpl(
      opcionSiNoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<OpcionSiNoRemoteDataSource>(
    () => OpcionSiNoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<OpcionSiNoLocalDataSource>(
    () => OpcionSiNoLocalDataSourceImpl(),
  );
}

void resguardoInit() {
  // cubit
  locator.registerFactory(() => ResguardoByDptoCubit(
        resguardoByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => ResguardoByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ResguardoByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ResguardoByDptoRepository>(
    () => ResguardoByDptoRepositoryImpl(
      resguardoByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ResguardoByDptoRepositoryDB>(
    () => ResguardoByDptoRepositoryDBImpl(
      resguardoByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ResguardoByDptoRemoteDataSource>(
    () => ResguardoByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ResguardoByDptoLocalDataSource>(
    () => ResguardoByDptoLocalDataSourceImpl(),
  );
}

void tiempoTardaMedTradicionalInit() {
  // cubit
  locator.registerFactory(() => TiempoTardaMedTradicionalCubit(
        tiempoTardaMedTradicionalUsecaseDB: locator(),
      ));

  // remote usecase
  locator
      .registerLazySingleton(() => TiempoTardaMedTradicionalUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => TiempoTardaMedTradicionalUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TiempoTardaMedTradicionalRepository>(
    () => TiempoTardaMedTradicionalRepositoryImpl(
      tiempoTardaMedTradicionalRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TiempoTardaMedTradicionalRepositoryDB>(
    () => TiempoTardaMedTradicionalRepositoryDBImpl(
      tiempoTardaMedTradicionalLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TiempoTardaMedTradicionalRemoteDataSource>(
    () => TiempoTardaMedTradicionalRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TiempoTardaMedTradicionalLocalDataSource>(
    () => TiempoTardaMedTradicionalLocalDataSourceImpl(),
  );
}

void tuberculoPlatanoByDptoInit() {
  // cubit
  locator.registerFactory(() => TuberculoPlatanoByDptoCubit(
        tuberculoPlatanoByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => TuberculoPlatanoByDptoUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => TuberculoPlatanoByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TuberculoPlatanoByDptoRepository>(
    () => TuberculoPlatanoByDptoRepositoryImpl(
      tuberculoPlatanoByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TuberculoPlatanoByDptoRepositoryDB>(
    () => TuberculoPlatanoByDptoRepositoryDBImpl(
      tuberculoPlatanoByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TuberculoPlatanoByDptoRemoteDataSource>(
    () => TuberculoPlatanoByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TuberculoPlatanoByDptoLocalDataSource>(
    () => TuberculoPlatanoByDptoLocalDataSourceImpl(),
  );
}

void verduraByDptoInit() {
  // cubit
  locator.registerFactory(() => VerduraByDptoCubit(
        verduraByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => VerduraByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => VerduraByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<VerduraByDptoRepository>(
    () => VerduraByDptoRepositoryImpl(
      verduraByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<VerduraByDptoRepositoryDB>(
    () => VerduraByDptoRepositoryDBImpl(
      verduraByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<VerduraByDptoRemoteDataSource>(
    () => VerduraByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<VerduraByDptoLocalDataSource>(
    () => VerduraByDptoLocalDataSourceImpl(),
  );
}

void factorRiesgoViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => FactorRiesgoViviendaByDptoCubit(
        factorRiesgoViviendaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(
      () => FactorRiesgoViviendaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => FactorRiesgoViviendaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<FactorRiesgoViviendaByDptoRepository>(
    () => FactorRiesgoViviendaByDptoRepositoryImpl(
      factorRiesgoViviendaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<FactorRiesgoViviendaByDptoRepositoryDB>(
    () => FactorRiesgoViviendaByDptoRepositoryDBImpl(
      factorRiesgoViviendaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<FactorRiesgoViviendaByDptoRemoteDataSource>(
    () => FactorRiesgoViviendaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<FactorRiesgoViviendaByDptoLocalDataSource>(
    () => FactorRiesgoViviendaByDptoLocalDataSourceImpl(),
  );
}

void iluminacionViviendaInit() {
  // cubit
  locator.registerFactory(() => IluminacionViviendaCubit(
        iluminacionViviendaUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => IluminacionViviendaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => IluminacionViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<IluminacionViviendaRepository>(
    () => IluminacionViviendaRepositoryImpl(
      iluminacionViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<IluminacionViviendaRepositoryDB>(
    () => IluminacionViviendaRepositoryDBImpl(
      iluminacionViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<IluminacionViviendaRemoteDataSource>(
    () => IluminacionViviendaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<IluminacionViviendaLocalDataSource>(
    () => IluminacionViviendaLocalDataSourceImpl(),
  );
}

void pisoViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => PisoViviendaByDptoCubit(
        pisoViviendaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => PisoViviendaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => PisoViviendaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PisoViviendaByDptoRepository>(
    () => PisoViviendaByDptoRepositoryImpl(
      pisoViviendaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PisoViviendaByDptoRepositoryDB>(
    () => PisoViviendaByDptoRepositoryDBImpl(
      pisoViviendaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PisoViviendaByDptoRemoteDataSource>(
    () => PisoViviendaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PisoViviendaByDptoLocalDataSource>(
    () => PisoViviendaByDptoLocalDataSourceImpl(),
  );
}

void presenciaAnimalViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => PresenciaAnimalViviendaByDptoCubit(
        presenciaAnimalViviendaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(
      () => PresenciaAnimalViviendaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => PresenciaAnimalViviendaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PresenciaAnimalViviendaByDptoRepository>(
    () => PresenciaAnimalViviendaByDptoRepositoryImpl(
      presenciaAnimalViviendaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PresenciaAnimalViviendaByDptoRepositoryDB>(
    () => PresenciaAnimalViviendaByDptoRepositoryDBImpl(
      presenciaAnimalViviendaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PresenciaAnimalViviendaByDptoRemoteDataSource>(
    () => PresenciaAnimalViviendaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PresenciaAnimalViviendaByDptoLocalDataSource>(
    () => PresenciaAnimalViviendaByDptoLocalDataSourceImpl(),
  );
}

void servicioPublicoViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => ServicioPublicoViviendaByDptoCubit(
        servicioPublicoViviendaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(
      () => ServicioPublicoViviendaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => ServicioPublicoViviendaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ServicioPublicoViviendaByDptoRepository>(
    () => ServicioPublicoViviendaByDptoRepositoryImpl(
      servicioPublicoViviendaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ServicioPublicoViviendaByDptoRepositoryDB>(
    () => ServicioPublicoViviendaByDptoRepositoryDBImpl(
      servicioPublicoViviendaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ServicioPublicoViviendaByDptoRemoteDataSource>(
    () => ServicioPublicoViviendaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ServicioPublicoViviendaByDptoLocalDataSource>(
    () => ServicioPublicoViviendaByDptoLocalDataSourceImpl(),
  );
}

void techoViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => TechoViviendaByDptoCubit(
        techoViviendaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => TechoViviendaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TechoViviendaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TechoViviendaByDptoRepository>(
    () => TechoViviendaByDptoRepositoryImpl(
      techoViviendaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TechoViviendaByDptoRepositoryDB>(
    () => TechoViviendaByDptoRepositoryDBImpl(
      techoViviendaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TechoViviendaByDptoRemoteDataSource>(
    () => TechoViviendaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TechoViviendaByDptoLocalDataSource>(
    () => TechoViviendaByDptoLocalDataSourceImpl(),
  );
}

void tenenciaViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => TenenciaViviendaByDptoCubit(
        tenenciaViviendaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => TenenciaViviendaByDptoUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => TenenciaViviendaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TenenciaViviendaByDptoRepository>(
    () => TenenciaViviendaByDptoRepositoryImpl(
      tenenciaViviendaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TenenciaViviendaByDptoRepositoryDB>(
    () => TenenciaViviendaByDptoRepositoryDBImpl(
      tenenciaViviendaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TenenciaViviendaByDptoRemoteDataSource>(
    () => TenenciaViviendaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TenenciaViviendaByDptoLocalDataSource>(
    () => TenenciaViviendaByDptoLocalDataSourceImpl(),
  );
}

void tipoCombustibleViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => TipoCombustibleViviendaByDptoCubit(
        tipoCombustibleViviendaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(
      () => TipoCombustibleViviendaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => TipoCombustibleViviendaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoCombustibleViviendaByDptoRepository>(
    () => TipoCombustibleViviendaByDptoRepositoryImpl(
      tipoCombustibleViviendaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoCombustibleViviendaByDptoRepositoryDB>(
    () => TipoCombustibleViviendaByDptoRepositoryDBImpl(
      tipoCombustibleViviendaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoCombustibleViviendaByDptoRemoteDataSource>(
    () => TipoCombustibleViviendaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoCombustibleViviendaByDptoLocalDataSource>(
    () => TipoCombustibleViviendaByDptoLocalDataSourceImpl(),
  );
}

void tipoSanitarioViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => TipoSanitarioViviendaByDptoCubit(
        tipoSanitarioViviendaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(
      () => TipoSanitarioViviendaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => TipoSanitarioViviendaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoSanitarioViviendaByDptoRepository>(
    () => TipoSanitarioViviendaByDptoRepositoryImpl(
      tipoSanitarioViviendaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoSanitarioViviendaByDptoRepositoryDB>(
    () => TipoSanitarioViviendaByDptoRepositoryDBImpl(
      tipoSanitarioViviendaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoSanitarioViviendaByDptoRemoteDataSource>(
    () => TipoSanitarioViviendaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoSanitarioViviendaByDptoLocalDataSource>(
    () => TipoSanitarioViviendaByDptoLocalDataSourceImpl(),
  );
}

void tipoViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => TipoViviendaByDptoCubit(
        tipoViviendaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => TipoViviendaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoViviendaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoViviendaByDptoRepository>(
    () => TipoViviendaByDptoRepositoryImpl(
      tipoViviendaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoViviendaByDptoRepositoryDB>(
    () => TipoViviendaByDptoRepositoryDBImpl(
      tipoViviendaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoViviendaByDptoRemoteDataSource>(
    () => TipoViviendaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoViviendaByDptoLocalDataSource>(
    () => TipoViviendaByDptoLocalDataSourceImpl(),
  );
}

void tratamientoAguaViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => TratamientoAguaViviendaByDptoCubit(
        tratamientoAguaViviendaByDptoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(
      () => TratamientoAguaViviendaByDptoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => TratamientoAguaViviendaByDptoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TratamientoAguaViviendaByDptoRepository>(
    () => TratamientoAguaViviendaByDptoRepositoryImpl(
      tratamientoAguaViviendaByDptoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TratamientoAguaViviendaByDptoRepositoryDB>(
    () => TratamientoAguaViviendaByDptoRepositoryDBImpl(
      tratamientoAguaViviendaByDptoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TratamientoAguaViviendaByDptoRemoteDataSource>(
    () => TratamientoAguaViviendaByDptoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TratamientoAguaViviendaByDptoLocalDataSource>(
    () => TratamientoAguaViviendaByDptoLocalDataSourceImpl(),
  );
}

void ventilacionViviendaByDptoInit() {
  // cubit
  locator.registerFactory(() => VentilacionViviendaCubit(
        ventilacionViviendaUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => VentilacionViviendaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => VentilacionViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<VentilacionViviendaRepository>(
    () => VentilacionViviendaRepositoryImpl(
      ventilacionViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<VentilacionViviendaRepositoryDB>(
    () => VentilacionViviendaRepositoryDBImpl(
      ventilacionViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<VentilacionViviendaRemoteDataSource>(
    () => VentilacionViviendaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<VentilacionViviendaLocalDataSource>(
    () => VentilacionViviendaLocalDataSourceImpl(),
  );
}

void fichaInit() {
  // bloc
  locator.registerFactory(() => FichaBloc(
        fichaUsecaseDB: locator(),
      ));

  // cubit
  locator.registerFactory(() => FichaCubit(
        fichaUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => FichaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => FichaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<FichaRepository>(
    () => FichaRepositoryImpl(
      fichaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<FichaRepositoryDB>(
    () => FichaRepositoryDBImpl(
      fichaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<FichaRemoteDataSource>(
    () => FichaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<FichaLocalDataSource>(
    () => FichaLocalDataSourceImpl(),
  );
}

void familiaInit() {
  // bloc
  locator.registerFactory(() => FamiliaBloc(
        familiaUsecaseDB: locator(),
      ));

  // cubit
  locator.registerFactory(() => FamiliaCubit(familiaUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => FamiliaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => FamiliaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<FamiliaRepository>(
    () => FamiliaRepositoryImpl(
      familiaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<FamiliaRepositoryDB>(
    () => FamiliaRepositoryDBImpl(
      familiaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<FamiliaRemoteDataSource>(
    () => FamiliaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<FamiliaLocalDataSource>(
    () => FamiliaLocalDataSourceImpl(),
  );
}

void dimUbicacionInit() {
  // bloc
  locator.registerFactory(() => DimUbicacionBloc(
      dimUbicacionUsecaseDB: locator(),
      cerealByDptoUsecaseDB: locator(),
      dificultadAccesoCAUsecaseDB: locator(),
      dificultadAccesoMedTradicionalByDptoUsecaseDB: locator(),
      especialidadMedTradicionalByDptoUsecaseDB: locator(),
      especieAnimalByDptoUsecaseDB: locator(),
      frutoByDptoUsecaseDB: locator(),
      hortalizaByDptoUsecaseDB: locator(),
      leguminosaByDptoUsecaseDB: locator(),
      medioComunicacionUsecaseDB: locator(),
      medioUtilizaMedTradicionalByDptoUsecaseDB: locator(),
      tuberculoPlatanoByDptoUsecaseDB: locator(),
      verduraByDptoUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => DimUbicacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => DimUbicacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<DimUbicacionRepository>(
    () => DimUbicacionRepositoryImpl(
      dimUbicacionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<DimUbicacionRepositoryDB>(
    () => DimUbicacionRepositoryDBImpl(
      dimUbicacionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<DimUbicacionRemoteDataSource>(
    () => DimUbicacionRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<DimUbicacionLocalDataSource>(
    () => DimUbicacionLocalDataSourceImpl(),
  );
}

void dimViviendaInit() {
  // bloc
  locator.registerFactory(() => DimViviendaBloc(
      dimViviendaUsecaseDB: locator(),
      factorRiesgoViviendaByDptoUsecaseDB: locator(),
      servicioPublicoViviendaByDptoUsecaseDB: locator(),
      techoViviendaByDptoUsecaseDB: locator(),
      tipoCombustibleViviendaByDptoUsecaseDB: locator(),
      tipoSanitarioViviendaByDptoUsecaseDB: locator(),
      tratamientoAguaViviendaByDptoUsecaseDB: locator(),
      presenciaAnimalViviendaByDptoUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => DimViviendaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => DimViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<DimViviendaRepository>(
    () => DimViviendaRepositoryImpl(
      dimViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<DimViviendaRepositoryDB>(
    () => DimViviendaRepositoryDBImpl(
      dimViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<DimViviendaRemoteDataSource>(
    () => DimViviendaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<DimViviendaLocalDataSource>(
    () => DimViviendaLocalDataSourceImpl(),
  );
}

void tipoCalendarioInit() {
  // bloc
  locator.registerFactory(
      () => TipoCalendarioCubit(tipoCalendarioUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => TipoCalendarioUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoCalendarioUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoCalendarioRepository>(
    () => TipoCalendarioRepositoryImpl(
      tipoCalendarioRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoCalendarioRepositoryDB>(
    () => TipoCalendarioRepositoryDBImpl(
      tipoCalendarioLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoCalendarioRemoteDataSource>(
    () => TipoCalendarioRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoCalendarioLocalDataSource>(
    () => TipoCalendarioLocalDataSourceImpl(),
  );
}

void grupoFamiliarInit() {
  // bloc
  locator.registerFactory(() => AfiliadosGrupoFamiliarBloc());

  // bloc
  locator.registerFactory(() => GrupoFamiliarBloc());
}
