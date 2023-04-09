import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'domain/usecases/afiliado/afiliado_exports.dart';
import 'domain/usecases/auth/auth_exports.dart';
import 'domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import 'domain/usecases/estado_via/estado_via_exports.dart';
import 'domain/usecases/medio_comunicacion/medio_comunicacion_exports.dart';
import 'domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import 'domain/usecases/sync_log/sync_log_exports.dart';
import 'domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
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
  // external
  locator.registerLazySingleton(() => http.Client());
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
