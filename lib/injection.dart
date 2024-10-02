import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'domain/usecases/actividad_fisica/actividad_fisica_exports.dart';
import 'domain/usecases/afiliado/afiliado_exports.dart';
import 'domain/usecases/alimentacion/alimentacion_exports.dart';
import 'domain/usecases/atencion_salud/atencion_salud_exports.dart';
import 'domain/usecases/auth/auth_exports.dart';
import 'domain/usecases/autoridad_indigena/autoridad_indigena_exports.dart';
import 'domain/usecases/cereal/cereal_exports.dart';
import 'domain/usecases/cigarrillo_dia/cigarrillo_dia_exports.dart';
import 'domain/usecases/condicion_nutricional/condicion_nutricional_exports.dart';
import 'domain/usecases/conducta_seguir/conducta_seguir_exports.dart';
import 'domain/usecases/consumo_alcohol/consumo_alcohol_exports.dart';
import 'domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import 'domain/usecases/costumbre_practica/costumbre_practica_exports.dart';
import 'domain/usecases/nro_cuarto_vivienda/nro_cuarto_vivienda_exports.dart';
import 'domain/usecases/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_exports.dart';
import 'domain/usecases/curso_vida/curso_vida_exports.dart';
import 'domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import 'domain/usecases/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_exports.dart';
import 'domain/usecases/dim_ubicacion/dim_ubicacion_exports.dart';
import 'domain/usecases/dim_vivienda/dim_vivienda_exports.dart';
import 'domain/usecases/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_exports.dart';
import 'domain/usecases/enfermedad_acude/enfermedad_acude_exports.dart';
import 'domain/usecases/enfermedad_tradicional/enfermedad_tradicional_exports.dart';
import 'domain/usecases/enfermedad_tratamiento/enfermedad_tratamiento_exports.dart';
import 'domain/usecases/especialidad_med_tradicional/especialidad_med_tradicional_exports.dart';
import 'domain/usecases/especie_animal/especie_animal_exports.dart';
import 'domain/usecases/esquema_vacunacion/esquema_vacunacion_exports.dart';
import 'domain/usecases/estado_via/estado_via_exports.dart';
import 'domain/usecases/estilo_vida_saludable/estilo_vida_saludable_exports.dart';
import 'domain/usecases/etnia/etnia_exports.dart';
import 'domain/usecases/evento_costumbre_participa/evento_costumbre_participa_exports.dart';
import 'domain/usecases/factor_riesgo_vivienda/factor_riesgo_vivienda_exports.dart';
import 'domain/usecases/familia/familia_exports.dart';
import 'domain/usecases/ficha/ficha_exports.dart';
import 'domain/usecases/fruto/fruto_exports.dart';
import 'domain/usecases/genero/genero_exports.dart';
import 'domain/usecases/grupo_familiar/grupo_familiar_exports.dart';
import 'domain/usecases/grupo_riesgo/grupo_riesgo_exports.dart';
import 'domain/usecases/hortaliza/hortaliza_exports.dart';
import 'domain/usecases/iluminacion_vivienda/iluminacion_vivienda_exports.dart';
import 'domain/usecases/leguminosa/leguminosa_exports.dart';
import 'domain/usecases/lengua_maneja/lengua_maneja_exports.dart';
import 'domain/usecases/lugar_atencion_medico/lugar_atencion_medico_exports.dart';
import 'domain/usecases/lugar_planta_medicinal/lugar_planta_medicinal_exports.dart';
import 'domain/usecases/lugar_vacunacion/lugar_vacunacion_exports.dart';
import 'domain/usecases/medio_comunicacion/medio_comunicacion_exports.dart';
import 'domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import 'domain/usecases/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_exports.dart';
import 'domain/usecases/metodo_planificacion/metodo_planificacion_exports.dart';
import 'domain/usecases/nivel_educativo/nivel_educativo_exports.dart';
import 'domain/usecases/nombre_enfermedad/nombre_enfermedad_exports.dart';
import 'domain/usecases/nombre_lengua_materna/nombre_lengua_materna_exports.dart';
import 'domain/usecases/ocupacion/ocupacion_exports.dart';
import 'domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import 'domain/usecases/parentesco/parentesco_exports.dart';
import 'domain/usecases/piso_vivienda/piso_vivienda_exports.dart';
import 'domain/usecases/planta_medicinal/planta_medicinal_exports.dart';
import 'domain/usecases/presencia_animal_vivienda/presencia_animal_vivienda_exports.dart';
import 'domain/usecases/pueblo_indigena/pueblo_indigena_exports.dart';
import 'domain/usecases/tipo_regimen/tipo_regimen_exports.dart';
import 'domain/usecases/religion_profesa/religion_profesa_exports.dart';
import 'domain/usecases/resguardo/resguardo_exports.dart';
import 'domain/usecases/sancion_justicia/sancion_justicia_exports.dart';
import 'domain/usecases/seguimiento_enfermedad/seguimiento_enfermedad_exports.dart';
import 'domain/usecases/servicio_publico_vivienda/servicio_publico_vivienda_exports.dart';
import 'domain/usecases/servicio_solicitado/servicio_solicitado_exports.dart';
import 'domain/usecases/techo_vivienda/techo_vivienda_exports.dart';
import 'domain/usecases/tenencia_vivienda/tenencia_vivienda_exports.dart';
import 'domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import 'domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';
import 'domain/usecases/tipo_calendario/tipo_calendario_exports.dart';
import 'domain/usecases/tipo_combustible_vivienda/tipo_combustible_vivienda_exports.dart';
import 'domain/usecases/tipo_documento/tipo_documento_exports.dart';
import 'domain/usecases/tipo_sanitario_vivienda/tipo_sanitario_vivienda_exports.dart';
import 'domain/usecases/tipo_vivienda/tipo_vivienda_exports.dart';
import 'domain/usecases/tratamiento_agua_vivienda/tratamiento_agua_vivienda_exports.dart';
import 'domain/usecases/tuberculo_platano/tuberculo_platano_exports.dart';
import 'domain/usecases/ultima_vez_inst_salud/ultima_vez_inst_salud_exports.dart';
import 'domain/usecases/ventilacion_vivienda/ventilacion_vivienda_exports.dart';
import 'domain/usecases/verdura/verdura_exports.dart';
import 'domain/usecases/via_acceso/via_acceso_exports.dart';
import 'services/shared_preferences_service.dart';
import 'ui/blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import 'ui/blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import 'ui/blocs/sync/sync_bloc.dart';
import 'ui/cubits/internet/internet_cubit.dart';

final locator = GetIt.instance;

void init() {
  authInit();
  internetInit();
  syncInit();
  afiliadoInit();
  afiliadoPrefsInit();
  dimUbicacionInit();
  dimViviendaInit();
  grupoFamiliarInit();
  estiloVidaSaludableInit();
  cuidadoSaludCondRiesgoInit();
  atencionSaludInit();
  dimensionSocioCulturalPueblosIndigenasInit();
  dificultadAccesoCAInit();
  estadoViaInit();
  medioComunicacionInit();
  medioUtilizaCAInit();
  tiempoTardaCAInit();
  viaAccesoInit();
  autoridadIndigenaInit();
  cerealInit();
  costoDesplazamientoInit();
  dificultadAccesoMedTradicionalInit();
  especialidadMedTradicionalInit();
  especieAnimalInit();
  frutoInit();
  hortalizaInit();
  leguminosaInit();
  medioUtilizaMedTradicionalInit();
  opcionSiNoInit();
  resguardoInit();
  tiempoTardaMedTradicionalInit();
  tuberculoPlatanoInit();
  verduraInit();
  factorRiesgoViviendaInit();
  iluminacionViviendaInit();
  pisoViviendaInit();
  presenciaAnimalViviendaInit();
  servicioPublicoViviendaInit();
  techoViviendaInit();
  tenenciaViviendaInit();
  tipoCombustibleViviendaInit();
  tipoSanitarioViviendaInit();
  tipoViviendaInit();
  tratamientoAguaViviendaInit();
  ventilacionViviendaInit();
  tipoCalendarioInit();
  fichaInit();
  familiaInit();
  cursoVidaInit();
  etniaInit();
  generoInit();
  grupoRiesgoInit();
  lenguaManejaInit();
  nivelEducativoInit();
  nombreLenguaMaternaInit();
  ocupacionInit();
  parentescoInit();
  puebloIndigenaInit();
  tiporegimenInit();
  tipoDocumentoInit();
  actividadFisicaInit();
  alimentacionInit();
  cigarrilloDiaInit();
  consumoAlcoholInit();
  condicionNutricionalInit();
  conductaSeguirInit();
  esquemaVacunacionInit();
  lugarVacunacionInit();
  metodoPlanificacionInit();
  nombreEnfermedadInit();
  seguimientoEnfermedadInit();
  servicioSolicitadoInit();
  ultimaVezInstSaludInit();
  enfermedadAcudeInit();
  enfermedadTratamientoInit();
  enfermedadTradicionalInit();
  lugarAtencionMedicoInit();
  lugarPlantaMedicinalInit();
  plantaMedicinalInit();
  religionProfesaInit();
  eventoCostumbreParticipaInit();
  costumbrePracticaInit();
  sancionJusticiaInit();
  nroCuartoViviendaInit();
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
      afiliadoUsecase: locator(),
      afiliadoUsecaseDB: locator(),
      fichaUsecase: locator(),
      fichaUsecaseDB: locator()));
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

void dimUbicacionInit() {
  // bloc
  locator.registerFactory(() => DimUbicacionBloc(
      dimUbicacionUsecaseDB: locator(),
      cerealUsecaseDB: locator(),
      dificultadAccesoCAUsecaseDB: locator(),
      dificultadAccesoMedTradicionalUsecaseDB: locator(),
      especialidadMedTradicionalUsecaseDB: locator(),
      especieAnimalUsecaseDB: locator(),
      frutoUsecaseDB: locator(),
      hortalizaUsecaseDB: locator(),
      leguminosaUsecaseDB: locator(),
      medioComunicacionUsecaseDB: locator(),
      medioUtilizaMedTradicionalUsecaseDB: locator(),
      tuberculoPlatanoUsecaseDB: locator(),
      verduraUsecaseDB: locator(),
      medioUtilizaCAUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => DimUbicacionUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<DimUbicacionRepositoryDB>(
    () => DimUbicacionRepositoryDBImpl(
      dimUbicacionLocalDataSource: locator(),
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
      factorRiesgoViviendaUsecaseDB: locator(),
      servicioPublicoViviendaUsecaseDB: locator(),
      techoViviendaUsecaseDB: locator(),
      tipoCombustibleViviendaUsecaseDB: locator(),
      tipoSanitarioViviendaUsecaseDB: locator(),
      tratamientoAguaViviendaUsecaseDB: locator(),
      presenciaAnimalViviendaUsecaseDB: locator(),
      pisoViviendaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => DimViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<DimViviendaRepositoryDB>(
    () => DimViviendaRepositoryDBImpl(
      dimViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<DimViviendaLocalDataSource>(
    () => DimViviendaLocalDataSourceImpl(),
  );
}

void grupoFamiliarInit() {
  // bloc
  locator.registerFactory(
      () => AfiliadosGrupoFamiliarBloc(grupoFamiliarUsecaseDB: locator()));

  // bloc
  locator.registerFactory(
      () => GrupoFamiliarBloc(grupoFamiliarUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => GrupoFamiliarUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<GrupoFamiliarRepositoryDB>(
    () => GrupoFamiliarRepositoryDBImpl(
      grupoFamiliarLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<GrupoFamiliarLocalDataSource>(
    () => GrupoFamiliarLocalDataSourceImpl(),
  );
}

void estiloVidaSaludableInit() {
  // bloc
  locator.registerFactory(
      () => EstiloVidaSaludableBloc(estiloVidaSaludableUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => EstiloVidaSaludableUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<EstiloVidaSaludableRepositoryDB>(
    () => EstiloVidaSaludableRepositoryDBImpl(
      estiloVidaSaludableLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EstiloVidaSaludableLocalDataSource>(
    () => EstiloVidaSaludableLocalDataSourceImpl(),
  );
}

void cuidadoSaludCondRiesgoInit() {
  // bloc
  locator.registerFactory(() => CuidadoSaludCondRiesgoBloc(
      cuidadoSaludCondRiesgoUsecaseDB: locator(),
      servicioSolicitadoUsecaseDB: locator(),
      nombreEnfermedadUsecaseDB: locator()));

  // local usecase
  locator
      .registerLazySingleton(() => CuidadoSaludCondRiesgoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<CuidadoSaludCondRiesgoRepositoryDB>(
    () => CuidadoSaludCondRiesgoRepositoryDBImpl(
      cuidadoSaludCondRiesgoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CuidadoSaludCondRiesgoLocalDataSource>(
    () => CuidadoSaludCondRiesgoLocalDataSourceImpl(),
  );
}

void atencionSaludInit() {
  // bloc
  locator.registerFactory(() => AtencionSaludBloc(
      atencionSaludUsecaseDB: locator(),
      enfermedadTradicionalUsecaseDB: locator(),
      especialidadMedTradicionalUsecaseDB: locator(),
      lugarAtencionMedicoUsecaseDB: locator(),
      plantaMedicinalUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => AtencionSaludUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<AtencionSaludRepositoryDB>(
    () => AtencionSaludRepositoryDBImpl(
      atencionSaludLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AtencionSaludLocalDataSource>(
    () => AtencionSaludLocalDataSourceImpl(),
  );
}

void dimensionSocioCulturalPueblosIndigenasInit() {
  // bloc
  locator.registerFactory(() => DimensionSocioCulturalPueblosIndigenasBloc(
      dimensionSocioCulturalPueblosIndigenasUsecaseDB: locator(),
      eventoCostumbreParticipaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(
      () => DimensionSocioCulturalPueblosIndigenasUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<
      DimensionSocioCulturalPueblosIndigenasRepositoryDB>(
    () => DimensionSocioCulturalPueblosIndigenasRepositoryDBImpl(
      dimensionSocioCulturalPueblosIndigenasLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<
      DimensionSocioCulturalPueblosIndigenasLocalDataSource>(
    () => DimensionSocioCulturalPueblosIndigenasLocalDataSourceImpl(),
  );
}

void dificultadAccesoCAInit() {
  // cubit
  locator.registerFactory(
      () => DificultadAccesoCACubit(dificultadAccesoCAUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => DificultadAccesoCAUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<DificultadAccesoCARepositoryDB>(
    () => DificultadAccesoCARepositoryDBImpl(
      dificultadAccesoCALocalDataSource: locator(),
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

  // local usecase
  locator.registerLazySingleton(() => EstadoViaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<EstadoViaRepositoryDB>(
    () => EstadoViaRepositoryDBImpl(
      estadoViaLocalDataSource: locator(),
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

  // local usecase
  locator.registerLazySingleton(() => MedioComunicacionUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<MedioComunicacionRepositoryDB>(
    () => MedioComunicacionRepositoryDBImpl(
      medioComunicacionLocalDataSource: locator(),
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

  // local usecase
  locator.registerLazySingleton(() => MedioUtilizaCAUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<MedioUtilizaCARepositoryDB>(
    () => MedioUtilizaCARepositoryDBImpl(
      medioUtilizaCALocalDataSource: locator(),
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

  // local usecase
  locator.registerLazySingleton(() => TiempoTardaCAUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TiempoTardaCARepositoryDB>(
    () => TiempoTardaCARepositoryDBImpl(
      tiempoTardaCALocalDataSource: locator(),
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

  // local usecase
  locator.registerLazySingleton(() => ViaAccesoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<ViaAccesoRepositoryDB>(
    () => ViaAccesoRepositoryDBImpl(
      viaAccesoLocalDataSource: locator(),
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

  // local usecase
  locator.registerLazySingleton(() => AutoridadIndigenaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<AutoridadIndigenaRepositoryDB>(
    () => AutoridadIndigenaRepositoryDBImpl(
      autoridadIndigenaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AutoridadIndigenaLocalDataSource>(
    () => AutoridadIndigenaLocalDataSourceImpl(),
  );
}

void cerealInit() {
  // cubit
  locator.registerFactory(() => CerealCubit(
        cerealUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => CerealUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<CerealRepositoryDB>(
    () => CerealRepositoryDBImpl(
      cerealLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CerealLocalDataSource>(
    () => CerealLocalDataSourceImpl(),
  );
}

void costoDesplazamientoInit() {
  // cubit
  locator.registerFactory(() => CostoDesplazamientoCubit(
        costoDesplazamientoUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => CostoDesplazamientoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<CostoDesplazamientoRepositoryDB>(
    () => CostoDesplazamientoRepositoryDBImpl(
      costoDesplazamientoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CostoDesplazamientoLocalDataSource>(
    () => CostoDesplazamientoLocalDataSourceImpl(),
  );
}

void dificultadAccesoMedTradicionalInit() {
  // cubit
  locator.registerFactory(() => DificultadAccesoMedTradicionalCubit(
        dificultadAccesoMedTradicionalUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(
      () => DificultadAccesoMedTradicionalUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<DificultadAccesoMedTradicionalRepositoryDB>(
    () => DificultadAccesoMedTradicionalRepositoryDBImpl(
      dificultadAccesoMedTradicionalLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<DificultadAccesoMedTradicionalLocalDataSource>(
    () => DificultadAccesoMedTradicionalLocalDataSourceImpl(),
  );
}

void especialidadMedTradicionalInit() {
  // cubit
  locator.registerFactory(() => EspecialidadMedTradicionalCubit(
        especialidadMedTradicionalUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(
      () => EspecialidadMedTradicionalUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<EspecialidadMedTradicionalRepositoryDB>(
    () => EspecialidadMedTradicionalRepositoryDBImpl(
      especialidadMedTradicionalLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EspecialidadMedTradicionalLocalDataSource>(
    () => EspecialidadMedTradicionalLocalDataSourceImpl(),
  );
}

void especieAnimalInit() {
  // cubit
  locator.registerFactory(() => EspecieAnimalCubit(
        especieAnimalUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => EspecieAnimalUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<EspecieAnimalRepositoryDB>(
    () => EspecieAnimalRepositoryDBImpl(
      especieAnimalLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EspecieAnimalLocalDataSource>(
    () => EspecieAnimalLocalDataSourceImpl(),
  );
}

void frutoInit() {
  // cubit
  locator.registerFactory(() => FrutoCubit(
        frutoUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => FrutoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<FrutoRepositoryDB>(
    () => FrutoRepositoryDBImpl(
      frutoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<FrutoLocalDataSource>(
    () => FrutoLocalDataSourceImpl(),
  );
}

void hortalizaInit() {
  // cubit
  locator.registerFactory(() => HortalizaCubit(
        hortalizaUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => HortalizaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<HortalizaRepositoryDB>(
    () => HortalizaRepositoryDBImpl(
      hortalizaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<HortalizaLocalDataSource>(
    () => HortalizaLocalDataSourceImpl(),
  );
}

void leguminosaInit() {
  // cubit
  locator.registerFactory(() => LeguminosaCubit(
        leguminosaUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => LeguminosaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<LeguminosaRepositoryDB>(
    () => LeguminosaRepositoryDBImpl(
      leguminosaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<LeguminosaLocalDataSource>(
    () => LeguminosaLocalDataSourceImpl(),
  );
}

void medioUtilizaMedTradicionalInit() {
  // cubit
  locator.registerFactory(() => MedioUtilizaMedTradicionalCubit(
        medioUtilizaMedTradicionalUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(
      () => MedioUtilizaMedTradicionalUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<MedioUtilizaMedTradicionalRepositoryDB>(
    () => MedioUtilizaMedTradicionalRepositoryDBImpl(
      medioUtilizaMedTradicionalLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<MedioUtilizaMedTradicionalLocalDataSource>(
    () => MedioUtilizaMedTradicionalLocalDataSourceImpl(),
  );
}

void opcionSiNoInit() {
  // cubit
  locator.registerFactory(() => OpcionSiNoCubit(
        opcionSiNoUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => OpcionSiNoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<OpcionSiNoRepositoryDB>(
    () => OpcionSiNoRepositoryDBImpl(
      opcionSiNoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<OpcionSiNoLocalDataSource>(
    () => OpcionSiNoLocalDataSourceImpl(),
  );
}

void resguardoInit() {
  // cubit
  locator.registerFactory(() => ResguardoCubit(
        resguardoUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => ResguardoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<ResguardoRepositoryDB>(
    () => ResguardoRepositoryDBImpl(
      resguardoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ResguardoLocalDataSource>(
    () => ResguardoLocalDataSourceImpl(),
  );
}

void tiempoTardaMedTradicionalInit() {
  // cubit
  locator.registerFactory(() => TiempoTardaMedTradicionalCubit(
        tiempoTardaMedTradicionalUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(
      () => TiempoTardaMedTradicionalUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TiempoTardaMedTradicionalRepositoryDB>(
    () => TiempoTardaMedTradicionalRepositoryDBImpl(
      tiempoTardaMedTradicionalLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TiempoTardaMedTradicionalLocalDataSource>(
    () => TiempoTardaMedTradicionalLocalDataSourceImpl(),
  );
}

void tuberculoPlatanoInit() {
  // cubit
  locator.registerFactory(() => TuberculoPlatanoCubit(
        tuberculoPlatanoUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => TuberculoPlatanoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TuberculoPlatanoRepositoryDB>(
    () => TuberculoPlatanoRepositoryDBImpl(
      tuberculoPlatanoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TuberculoPlatanoLocalDataSource>(
    () => TuberculoPlatanoLocalDataSourceImpl(),
  );
}

void verduraInit() {
  // cubit
  locator.registerFactory(() => VerduraCubit(
        verduraUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => VerduraUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<VerduraRepositoryDB>(
    () => VerduraRepositoryDBImpl(
      verduraLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<VerduraLocalDataSource>(
    () => VerduraLocalDataSourceImpl(),
  );
}

void factorRiesgoViviendaInit() {
  // cubit
  locator.registerFactory(() => FactorRiesgoViviendaCubit(
        factorRiesgoViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => FactorRiesgoViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<FactorRiesgoViviendaRepositoryDB>(
    () => FactorRiesgoViviendaRepositoryDBImpl(
      factorRiesgoViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<FactorRiesgoViviendaLocalDataSource>(
    () => FactorRiesgoViviendaLocalDataSourceImpl(),
  );
}

void iluminacionViviendaInit() {
  // cubit
  locator.registerFactory(() => IluminacionViviendaCubit(
        iluminacionViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => IluminacionViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<IluminacionViviendaRepositoryDB>(
    () => IluminacionViviendaRepositoryDBImpl(
      iluminacionViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<IluminacionViviendaLocalDataSource>(
    () => IluminacionViviendaLocalDataSourceImpl(),
  );
}

void pisoViviendaInit() {
  // cubit
  locator.registerFactory(() => PisoViviendaCubit(
        pisoViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => PisoViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<PisoViviendaRepositoryDB>(
    () => PisoViviendaRepositoryDBImpl(
      pisoViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PisoViviendaLocalDataSource>(
    () => PisoViviendaLocalDataSourceImpl(),
  );
}

void presenciaAnimalViviendaInit() {
  // cubit
  locator.registerFactory(() => PresenciaAnimalViviendaCubit(
        presenciaAnimalViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator
      .registerLazySingleton(() => PresenciaAnimalViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<PresenciaAnimalViviendaRepositoryDB>(
    () => PresenciaAnimalViviendaRepositoryDBImpl(
      presenciaAnimalViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PresenciaAnimalViviendaLocalDataSource>(
    () => PresenciaAnimalViviendaLocalDataSourceImpl(),
  );
}

void servicioPublicoViviendaInit() {
  // cubit
  locator.registerFactory(() => ServicioPublicoViviendaCubit(
        servicioPublicoViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator
      .registerLazySingleton(() => ServicioPublicoViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<ServicioPublicoViviendaRepositoryDB>(
    () => ServicioPublicoViviendaRepositoryDBImpl(
      servicioPublicoViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ServicioPublicoViviendaLocalDataSource>(
    () => ServicioPublicoViviendaLocalDataSourceImpl(),
  );
}

void techoViviendaInit() {
  // cubit
  locator.registerFactory(() => TechoViviendaCubit(
        techoViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => TechoViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TechoViviendaRepositoryDB>(
    () => TechoViviendaRepositoryDBImpl(
      techoViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TechoViviendaLocalDataSource>(
    () => TechoViviendaLocalDataSourceImpl(),
  );
}

void tenenciaViviendaInit() {
  // cubit
  locator.registerFactory(() => TenenciaViviendaCubit(
        tenenciaViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => TenenciaViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TenenciaViviendaRepositoryDB>(
    () => TenenciaViviendaRepositoryDBImpl(
      tenenciaViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TenenciaViviendaLocalDataSource>(
    () => TenenciaViviendaLocalDataSourceImpl(),
  );
}

void tipoCombustibleViviendaInit() {
  // cubit
  locator.registerFactory(() => TipoCombustibleViviendaCubit(
        tipoCombustibleViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator
      .registerLazySingleton(() => TipoCombustibleViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TipoCombustibleViviendaRepositoryDB>(
    () => TipoCombustibleViviendaRepositoryDBImpl(
      tipoCombustibleViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoCombustibleViviendaLocalDataSource>(
    () => TipoCombustibleViviendaLocalDataSourceImpl(),
  );
}

void tipoSanitarioViviendaInit() {
  // cubit
  locator.registerFactory(() => TipoSanitarioViviendaCubit(
        tipoSanitarioViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator
      .registerLazySingleton(() => TipoSanitarioViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TipoSanitarioViviendaRepositoryDB>(
    () => TipoSanitarioViviendaRepositoryDBImpl(
      tipoSanitarioViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoSanitarioViviendaLocalDataSource>(
    () => TipoSanitarioViviendaLocalDataSourceImpl(),
  );
}

void tipoViviendaInit() {
  // cubit
  locator.registerFactory(() => TipoViviendaCubit(
        tipoViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => TipoViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TipoViviendaRepositoryDB>(
    () => TipoViviendaRepositoryDBImpl(
      tipoViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoViviendaLocalDataSource>(
    () => TipoViviendaLocalDataSourceImpl(),
  );
}

void tratamientoAguaViviendaInit() {
  // cubit
  locator.registerFactory(() => TratamientoAguaViviendaCubit(
        tratamientoAguaViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator
      .registerLazySingleton(() => TratamientoAguaViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TratamientoAguaViviendaRepositoryDB>(
    () => TratamientoAguaViviendaRepositoryDBImpl(
      tratamientoAguaViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TratamientoAguaViviendaLocalDataSource>(
    () => TratamientoAguaViviendaLocalDataSourceImpl(),
  );
}

void ventilacionViviendaInit() {
  // cubit
  locator.registerFactory(() => VentilacionViviendaCubit(
        ventilacionViviendaUsecaseDB: locator(),
      ));

  // local usecase
  locator.registerLazySingleton(() => VentilacionViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<VentilacionViviendaRepositoryDB>(
    () => VentilacionViviendaRepositoryDBImpl(
      ventilacionViviendaLocalDataSource: locator(),
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

  // local usecase
  locator.registerLazySingleton(() => FamiliaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<FamiliaRepositoryDB>(
    () => FamiliaRepositoryDBImpl(
      familiaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<FamiliaLocalDataSource>(
    () => FamiliaLocalDataSourceImpl(),
  );
}

void tipoCalendarioInit() {
  // bloc
  locator.registerFactory(
      () => TipoCalendarioCubit(tipoCalendarioUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoCalendarioUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TipoCalendarioRepositoryDB>(
    () => TipoCalendarioRepositoryDBImpl(
      tipoCalendarioLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoCalendarioLocalDataSource>(
    () => TipoCalendarioLocalDataSourceImpl(),
  );
}

void cursoVidaInit() {
  // cubit
  locator.registerFactory(() => CursoVidaCubit(cursoVidaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => CursoVidaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<CursoVidaRepositoryDB>(
    () => CursoVidaRepositoryDBImpl(
      cursoVidaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CursoVidaLocalDataSource>(
    () => CursoVidaLocalDataSourceImpl(),
  );
}

void etniaInit() {
  // cubit
  locator.registerFactory(() => EtniaCubit(etniaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => EtniaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<EtniaRepositoryDB>(
    () => EtniaRepositoryDBImpl(
      etniaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EtniaLocalDataSource>(
    () => EtniaLocalDataSourceImpl(),
  );
}

void generoInit() {
  // cubit
  locator.registerFactory(() => GeneroCubit(generoUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => GeneroUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<GeneroRepositoryDB>(
    () => GeneroRepositoryDBImpl(
      generoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<GeneroLocalDataSource>(
    () => GeneroLocalDataSourceImpl(),
  );
}

void grupoRiesgoInit() {
  // cubit
  locator
      .registerFactory(() => GrupoRiesgoCubit(grupoRiesgoUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => GrupoRiesgoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<GrupoRiesgoRepositoryDB>(
    () => GrupoRiesgoRepositoryDBImpl(
      grupoRiesgoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<GrupoRiesgoLocalDataSource>(
    () => GrupoRiesgoLocalDataSourceImpl(),
  );
}

void lenguaManejaInit() {
  // cubit
  locator.registerFactory(
      () => LenguaManejaCubit(lenguaManejaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => LenguaManejaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<LenguaManejaRepositoryDB>(
    () => LenguaManejaRepositoryDBImpl(
      lenguaManejaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<LenguaManejaLocalDataSource>(
    () => LenguaManejaLocalDataSourceImpl(),
  );
}

void nivelEducativoInit() {
  // cubit
  locator.registerFactory(
      () => NivelEducativoCubit(nivelEducativoUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => NivelEducativoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<NivelEducativoRepositoryDB>(
    () => NivelEducativoRepositoryDBImpl(
      nivelEducativoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<NivelEducativoLocalDataSource>(
    () => NivelEducativoLocalDataSourceImpl(),
  );
}

void nombreLenguaMaternaInit() {
  // cubit
  locator.registerFactory(
      () => NombreLenguaMaternaCubit(nombreLenguaMaternaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => NombreLenguaMaternaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<NombreLenguaMaternaRepositoryDB>(
    () => NombreLenguaMaternaRepositoryDBImpl(
      nombreLenguaMaternaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<NombreLenguaMaternaLocalDataSource>(
    () => NombreLenguaMaternaLocalDataSourceImpl(),
  );
}

void ocupacionInit() {
  // cubit
  locator.registerFactory(() => OcupacionCubit(ocupacionUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => OcupacionUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<OcupacionRepositoryDB>(
    () => OcupacionRepositoryDBImpl(
      ocupacionLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<OcupacionLocalDataSource>(
    () => OcupacionLocalDataSourceImpl(),
  );
}

void parentescoInit() {
  // cubit
  locator
      .registerFactory(() => ParentescoCubit(parentescoUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => ParentescoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<ParentescoRepositoryDB>(
    () => ParentescoRepositoryDBImpl(
      parentescoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ParentescoLocalDataSource>(
    () => ParentescoLocalDataSourceImpl(),
  );
}

void puebloIndigenaInit() {
  // cubit
  locator.registerFactory(
      () => PuebloIndigenaCubit(puebloIndigenaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => PuebloIndigenaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<PuebloIndigenaRepositoryDB>(
    () => PuebloIndigenaRepositoryDBImpl(
      puebloIndigenaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PuebloIndigenaLocalDataSource>(
    () => PuebloIndigenaLocalDataSourceImpl(),
  );
}

void tiporegimenInit() {
  // cubit
  locator
      .registerFactory(() => TipoRegimenCubit(tipoRegimenUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoRegimenUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TipoRegimenRepositoryDB>(
    () => TipoRegimenRepositoryDBImpl(
      tipoRegimenLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoRegimenLocalDataSource>(
    () => TipoRegimenLocalDataSourceImpl(),
  );
}

void tipoDocumentoInit() {
  // cubit
  locator.registerFactory(
      () => TipoDocumentoCubit(tipoDocumentoUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoDocumentoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<TipoDocumentoRepositoryDB>(
    () => TipoDocumentoRepositoryDBImpl(
      tipoDocumentoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoDocumentoLocalDataSource>(
    () => TipoDocumentoLocalDataSourceImpl(),
  );
}

void actividadFisicaInit() {
  // cubit
  locator.registerFactory(
      () => ActividadFisicaCubit(actividadFisicaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => ActividadFisicaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<ActividadFisicaRepositoryDB>(
    () => ActividadFisicaRepositoryDBImpl(
      actividadFisicaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ActividadFisicaLocalDataSource>(
    () => ActividadFisicaLocalDataSourceImpl(),
  );
}

void alimentacionInit() {
  // cubit
  locator.registerFactory(
      () => AlimentacionCubit(alimentacionUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => AlimentacionUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<AlimentacionRepositoryDB>(
    () => AlimentacionRepositoryDBImpl(
      alimentacionLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AlimentacionLocalDataSource>(
    () => AlimentacionLocalDataSourceImpl(),
  );
}

void cigarrilloDiaInit() {
  // cubit
  locator.registerFactory(
      () => CigarrilloDiaCubit(cigarrilloDiaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => CigarrilloDiaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<CigarrilloDiaRepositoryDB>(
    () => CigarrilloDiaRepositoryDBImpl(
      cigarrilloDiaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CigarrilloDiaLocalDataSource>(
    () => CigarrilloDiaLocalDataSourceImpl(),
  );
}

void consumoAlcoholInit() {
  // cubit
  locator.registerFactory(
      () => ConsumoAlcoholCubit(consumoAlcoholUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => ConsumoAlcoholUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<ConsumoAlcoholRepositoryDB>(
    () => ConsumoAlcoholRepositoryDBImpl(
      consumoAlcoholLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ConsumoAlcoholLocalDataSource>(
    () => ConsumoAlcoholLocalDataSourceImpl(),
  );
}

void condicionNutricionalInit() {
  // cubit
  locator.registerFactory(() =>
      CondicionNutricionalCubit(condicionNutricionalUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => CondicionNutricionalUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<CondicionNutricionalRepositoryDB>(
    () => CondicionNutricionalRepositoryDBImpl(
      condicionNutricionalLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CondicionNutricionalLocalDataSource>(
    () => CondicionNutricionalLocalDataSourceImpl(),
  );
}

void conductaSeguirInit() {
  // cubit
  locator.registerFactory(
      () => ConductaSeguirCubit(conductaSeguirUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => ConductaSeguirUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<ConductaSeguirRepositoryDB>(
    () => ConductaSeguirRepositoryDBImpl(
      conductaSeguirLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ConductaSeguirLocalDataSource>(
    () => ConductaSeguirLocalDataSourceImpl(),
  );
}

void esquemaVacunacionInit() {
  // cubit
  locator.registerFactory(
      () => EsquemaVacunacionCubit(esquemaVacunacionUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => EsquemaVacunacionUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<EsquemaVacunacionRepositoryDB>(
    () => EsquemaVacunacionRepositoryDBImpl(
      esquemaVacunacionLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EsquemaVacunacionLocalDataSource>(
    () => EsquemaVacunacionLocalDataSourceImpl(),
  );
}

void lugarVacunacionInit() {
  // cubit
  locator.registerFactory(
      () => LugarVacunacionCubit(lugarVacunacionUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => LugarVacunacionUsecaseDB(locator()));

  // local data source
  locator.registerLazySingleton<LugarVacunacionLocalDataSource>(
    () => LugarVacunacionLocalDataSourceImpl(),
  );
}

void metodoPlanificacionInit() {
  // cubit
  locator.registerFactory(
      () => MetodoPlanificacionCubit(metodoPlanificacionUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => MetodoPlanificacionUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<MetodoPlanificacionRepositoryDB>(
    () => MetodoPlanificacionRepositoryDBImpl(
      metodoPlanificacionLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<MetodoPlanificacionLocalDataSource>(
    () => MetodoPlanificacionLocalDataSourceImpl(),
  );
}

void nombreEnfermedadInit() {
  // cubit
  locator.registerFactory(
      () => NombreEnfermedadCubit(nombreEnfermedadUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => NombreEnfermedadUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<NombreEnfermedadRepositoryDB>(
    () => NombreEnfermedadRepositoryDBImpl(
      nombreEnfermedadLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<NombreEnfermedadLocalDataSource>(
    () => NombreEnfermedadLocalDataSourceImpl(),
  );
}

void seguimientoEnfermedadInit() {
  // cubit
  locator.registerFactory(() =>
      SeguimientoEnfermedadCubit(seguimientoEnfermedadUsecaseDB: locator()));

  // local usecase
  locator
      .registerLazySingleton(() => SeguimientoEnfermedadUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<SeguimientoEnfermedadRepositoryDB>(
    () => SeguimientoEnfermedadRepositoryDBImpl(
      seguimientoEnfermedadLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<SeguimientoEnfermedadLocalDataSource>(
    () => SeguimientoEnfermedadLocalDataSourceImpl(),
  );
}

void servicioSolicitadoInit() {
  // cubit
  locator.registerFactory(
      () => ServicioSolicitadoCubit(servicioSolicitadoUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => ServicioSolicitadoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<ServicioSolicitadoRepositoryDB>(
    () => ServicioSolicitadoRepositoryDBImpl(
      servicioSolicitadoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ServicioSolicitadoLocalDataSource>(
    () => ServicioSolicitadoLocalDataSourceImpl(),
  );
}

void ultimaVezInstSaludInit() {
  // cubit
  locator.registerFactory(
      () => UltimaVezInstSaludCubit(ultimaVezInstSaludUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => UltimaVezInstSaludUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<UltimaVezInstSaludRepositoryDB>(
    () => UltimaVezInstSaludRepositoryDBImpl(
      ultimaVezInstSaludLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<UltimaVezInstSaludLocalDataSource>(
    () => UltimaVezInstSaludLocalDataSourceImpl(),
  );
}

void enfermedadAcudeInit() {
  // cubit
  locator.registerFactory(
      () => EnfermedadAcudeCubit(enfermedadAcudeUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => EnfermedadAcudeUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<EnfermedadAcudeRepositoryDB>(
    () => EnfermedadAcudeRepositoryDBImpl(
      enfermedadAcudeLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EnfermedadAcudeLocalDataSource>(
    () => EnfermedadAcudeLocalDataSourceImpl(),
  );
}

void enfermedadTratamientoInit() {
  // cubit
  locator.registerFactory(() =>
      EnfermedadTratamientoCubit(enfermedadTratamientoUsecaseDB: locator()));

  // local usecase
  locator
      .registerLazySingleton(() => EnfermedadTratamientoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<EnfermedadTratamientoRepositoryDB>(
    () => EnfermedadTratamientoRepositoryDBImpl(
      enfermedadTratamientoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EnfermedadTratamientoLocalDataSource>(
    () => EnfermedadTratamientoLocalDataSourceImpl(),
  );
}

void enfermedadTradicionalInit() {
  // cubit
  locator.registerFactory(() =>
      EnfermedadTradicionalCubit(enfermedadTradicionalUsecaseDB: locator()));

  // local usecase
  locator
      .registerLazySingleton(() => EnfermedadTradicionalUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<EnfermedadTradicionalRepositoryDB>(
    () => EnfermedadTradicionalRepositoryDBImpl(
      enfermedadTradicionalLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EnfermedadTradicionalLocalDataSource>(
    () => EnfermedadTradicionalLocalDataSourceImpl(),
  );
}

void lugarAtencionMedicoInit() {
  // cubit
  locator.registerFactory(
      () => LugarAtencionMedicoCubit(lugarAtencionMedicoUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => LugarAtencionMedicoUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<LugarAtencionMedicoRepositoryDB>(
    () => LugarAtencionMedicoRepositoryDBImpl(
      lugarAtencionMedicoLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<LugarAtencionMedicoLocalDataSource>(
    () => LugarAtencionMedicoLocalDataSourceImpl(),
  );
}

void lugarPlantaMedicinalInit() {
  // cubit
  locator.registerFactory(() =>
      LugarPlantaMedicinalCubit(lugarPlantaMedicinalUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => LugarPlantaMedicinalUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<LugarPlantaMedicinalRepositoryDB>(
    () => LugarPlantaMedicinalRepositoryDBImpl(
      lugarPlantaMedicinalLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<LugarPlantaMedicinalLocalDataSource>(
    () => LugarPlantaMedicinalLocalDataSourceImpl(),
  );
}

void plantaMedicinalInit() {
  // cubit
  locator.registerFactory(
      () => PlantaMedicinalCubit(plantaMedicinalUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => PlantaMedicinalUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<PlantaMedicinalRepositoryDB>(
    () => PlantaMedicinalRepositoryDBImpl(
      plantaMedicinalLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PlantaMedicinalLocalDataSource>(
    () => PlantaMedicinalLocalDataSourceImpl(),
  );
}

void religionProfesaInit() {
  // cubit
  locator.registerFactory(
      () => ReligionProfesaCubit(religionProfesaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => ReligionProfesaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<ReligionProfesaRepositoryDB>(
    () => ReligionProfesaRepositoryDBImpl(
      religionProfesaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ReligionProfesaLocalDataSource>(
    () => ReligionProfesaLocalDataSourceImpl(),
  );
}

void eventoCostumbreParticipaInit() {
  // cubit
  locator.registerFactory(() => EventoCostumbreParticipaCubit(
      eventoCostumbreParticipaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(
      () => EventoCostumbreParticipaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<EventoCostumbreParticipaRepositoryDB>(
    () => EventoCostumbreParticipaRepositoryDBImpl(
      eventoCostumbreParticipaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EventoCostumbreParticipaLocalDataSource>(
    () => EventoCostumbreParticipaLocalDataSourceImpl(),
  );
}

void costumbrePracticaInit() {
  // cubit
  locator.registerFactory(
      () => CostumbrePracticaCubit(costumbrePracticaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => CostumbrePracticaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<CostumbrePracticaRepositoryDB>(
    () => CostumbrePracticaRepositoryDBImpl(
      costumbrePracticaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CostumbrePracticaLocalDataSource>(
    () => CostumbrePracticaLocalDataSourceImpl(),
  );
}

void sancionJusticiaInit() {
  // cubit
  locator.registerFactory(
      () => SancionJusticiaCubit(sancionJusticiaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => SancionJusticiaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<SancionJusticiaRepositoryDB>(
    () => SancionJusticiaRepositoryDBImpl(
      sancionJusticiaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<SancionJusticiaLocalDataSource>(
    () => SancionJusticiaLocalDataSourceImpl(),
  );
}

void nroCuartoViviendaInit() {
  // cubit
  locator.registerFactory(
      () => NroCuartoViviendaCubit(nroCuartoViviendaUsecaseDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => NroCuartoViviendaUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<NroCuartoViviendaRepositoryDB>(
    () => NroCuartoViviendaRepositoryDBImpl(
      nroCuartoViviendaLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<NroCuartoViviendaLocalDataSource>(
    () => NroCuartoViviendaLocalDataSourceImpl(),
  );
}
