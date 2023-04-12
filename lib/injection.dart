import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'domain/usecases/afiliado/afiliado_exports.dart';
import 'domain/usecases/auth/auth_exports.dart';
import 'domain/usecases/autoridad_indigena/autoridad_indigena_exports.dart';
import 'domain/usecases/cereal_by_dpto/cereal_by_dpto_exports.dart';
import 'domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import 'domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import 'domain/usecases/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_exports.dart';
import 'domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_exports.dart';
import 'domain/usecases/especie_animal_by_dpto/especie_animal_by_dpto_exports.dart';
import 'domain/usecases/estado_via/estado_via_exports.dart';
import 'domain/usecases/fruto_by_dpto/fruto_by_dpto_exports.dart';
import 'domain/usecases/hortaliza_by_dpto/hortaliza_by_dpto_exports.dart';
import 'domain/usecases/leguminosa_by_dpto/leguminosa_by_dpto_exports.dart';
import 'domain/usecases/medio_comunicacion/medio_comunicacion_exports.dart';
import 'domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import 'domain/usecases/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_exports.dart';
import 'domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import 'domain/usecases/resguardo_by_dpto/resguardo_by_dpto_exports.dart';
import 'domain/usecases/sync_log/sync_log_exports.dart';
import 'domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import 'domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';
import 'domain/usecases/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_exports.dart';
import 'domain/usecases/verdura_by_dpto/verdura_by_dpto_exports.dart';
import 'domain/usecases/via_acceso/via_acceso_exports.dart';
import 'ui/blocs/sync/sync_bloc.dart';
import 'ui/cubits/internet/internet_cubit.dart';

final locator = GetIt.instance;

void init() {
  authBlocInit();
  internetCubitInit();
  syncInit();
  syncLogInit();
  afiliadoBlocInit();
  dificultadAccesoCACubitInit();
  estadoViaCubitInit();
  medioComunicacionCubitInit();
  medioUtilizaCACubitInit();
  tiempoTardaCACubitInit();
  viaAccesoCubitInit();
  autoridadIndigenaCubitInit();
  cerealByDptoCubitInit();
  costoDesplazamientoCubitInit();
  dificultadAccesoMedTradicionalByDptoCubitInit();
  especialidadMedTradicionalByDptoCubitInit();
  especieAnimalByDptoCubitInit();
  frutoByDptoCubitInit();
  hortalizaByDptoCubitInit();
  leguminosaByDptoCubitInit();
  medioUtilizaMedTradicionalByDptoCubitInit();
  opcionSiNoCubitInit();
  resguardoCubitInit();
  tiempoTardaMedTradicionalCubitInit();
  tuberculoPlatanoByDptoCubitInit();
  verduraByDptoCubitInit();
  // external
  locator.registerLazySingleton(() => http.Client());
}

void authBlocInit() {
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

void internetCubitInit() {
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

void afiliadoBlocInit() {
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

void dificultadAccesoCACubitInit() {
  // bloc
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

void estadoViaCubitInit() {
  // bloc
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

void medioComunicacionCubitInit() {
  // bloc
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

void medioUtilizaCACubitInit() {
  // bloc
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

void tiempoTardaCACubitInit() {
  // bloc
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

void viaAccesoCubitInit() {
  // bloc
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

void autoridadIndigenaCubitInit() {
  // bloc
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

void cerealByDptoCubitInit() {
  // bloc
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

void costoDesplazamientoCubitInit() {
  // bloc
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

void dificultadAccesoMedTradicionalByDptoCubitInit() {
  // bloc
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

void especialidadMedTradicionalByDptoCubitInit() {
  // bloc
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

void especieAnimalByDptoCubitInit() {
  // bloc
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

void frutoByDptoCubitInit() {
  // bloc
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

void hortalizaByDptoCubitInit() {
  // bloc
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

void leguminosaByDptoCubitInit() {
  // bloc
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

void medioUtilizaMedTradicionalByDptoCubitInit() {
  // bloc
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

void opcionSiNoCubitInit() {
  // bloc
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

void resguardoCubitInit() {
  // bloc
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

void tiempoTardaMedTradicionalCubitInit() {
  // bloc
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

void tuberculoPlatanoByDptoCubitInit() {
  // bloc
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

void verduraByDptoCubitInit() {
  // bloc
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
