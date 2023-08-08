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
import 'domain/usecases/regimen/regimen_exports.dart';
import 'domain/usecases/religion_profesa/religion_profesa_exports.dart';
import 'domain/usecases/resguardo/resguardo_exports.dart';
import 'domain/usecases/sancion_justicia/sancion_justicia_exports.dart';
import 'domain/usecases/seguimiento_enfermedad/seguimiento_enfermedad_exports.dart';
import 'domain/usecases/servicio_publico_vivienda/servicio_publico_vivienda_exports.dart';
import 'domain/usecases/servicio_solicitado/servicio_solicitado_exports.dart';
import 'domain/usecases/sync_log/sync_log_exports.dart';
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
import 'ui/blocs/encuesta/encuesta_bloc.dart';
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
  regimenInit();
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
  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerFactory(() => EncuestaBloc());
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
        cerealUsecase: locator(),
        cerealUsecaseDB: locator(),
        costoDesplazamientoUsecase: locator(),
        costoDesplazamientoUsecaseDB: locator(),
        dificultadAccesoMedTradicionalUsecase: locator(),
        dificultadAccesoMedTradicionalUsecaseDB: locator(),
        especialidadMedTradicionalUsecase: locator(),
        especialidadMedTradicionalUsecaseDB: locator(),
        especieAnimalUsecase: locator(),
        especieAnimalUsecaseDB: locator(),
        frutoUsecase: locator(),
        frutoUsecaseDB: locator(),
        hortalizaUsecase: locator(),
        hortalizaUsecaseDB: locator(),
        leguminosaUsecase: locator(),
        leguminosaUsecaseDB: locator(),
        medioUtilizaMedTradicionalUsecase: locator(),
        medioUtilizaMedTradicionalUsecaseDB: locator(),
        opcionSiNoUsecase: locator(),
        opcionSiNoUsecaseDB: locator(),
        resguardoUsecase: locator(),
        resguardoUsecaseDB: locator(),
        tiempoTardaMedTradicionalUsecase: locator(),
        tiempoTardaMedTradicionalUsecaseDB: locator(),
        tuberculoPlatanoUsecase: locator(),
        tuberculoPlatanoUsecaseDB: locator(),
        verduraUsecase: locator(),
        verduraUsecaseDB: locator(),
        factorRiesgoViviendaUsecase: locator(),
        factorRiesgoViviendaUsecaseDB: locator(),
        iluminacionViviendaUsecase: locator(),
        iluminacionViviendaUsecaseDB: locator(),
        pisoViviendaUsecase: locator(),
        pisoViviendaUsecaseDB: locator(),
        presenciaAnimalViviendaUsecase: locator(),
        presenciaAnimalViviendaUsecaseDB: locator(),
        servicioPublicoViviendaUsecase: locator(),
        servicioPublicoViviendaUsecaseDB: locator(),
        techoViviendaUsecase: locator(),
        techoViviendaUsecaseDB: locator(),
        tenenciaViviendaUsecase: locator(),
        tenenciaViviendaUsecaseDB: locator(),
        tipoCombustibleViviendaUsecase: locator(),
        tipoCombustibleViviendaUsecaseDB: locator(),
        tipoSanitarioViviendaUsecase: locator(),
        tipoSanitarioViviendaUsecaseDB: locator(),
        tratamientoAguaViviendaUsecase: locator(),
        tratamientoAguaViviendaUsecaseDB: locator(),
        ventilacionViviendaUsecase: locator(),
        ventilacionViviendaUsecaseDB: locator(),
        tipoViviendaUsecase: locator(),
        tipoViviendaUsecaseDB: locator(),
        tipoCalendarioUsecase: locator(),
        tipoCalendarioUsecaseDB: locator(),
        cursoVidaUsecase: locator(),
        cursoVidaUsecaseDB: locator(),
        etniaUsecase: locator(),
        etniaUsecaseDB: locator(),
        generoUsecase: locator(),
        generoUsecaseDB: locator(),
        grupoRiesgoUsecase: locator(),
        grupoRiesgoUsecaseDB: locator(),
        lenguaManejaUsecase: locator(),
        lenguaManejaUsecaseDB: locator(),
        nivelEducativoUsecase: locator(),
        nivelEducativoUsecaseDB: locator(),
        nombreLenguaMaternaUsecase: locator(),
        nombreLenguaMaternaUsecaseDB: locator(),
        ocupacionUsecase: locator(),
        ocupacionUsecaseDB: locator(),
        parentescoUsecase: locator(),
        parentescoUsecaseDB: locator(),
        puebloIndigenaUsecase: locator(),
        puebloIndigenaUsecaseDB: locator(),
        regimenUsecase: locator(),
        regimenUsecaseDB: locator(),
        tipoDocumentoUsecase: locator(),
        tipoDocumentoUsecaseDB: locator(),
        actividadFisicaUsecase: locator(),
        actividadFisicaUsecaseDB: locator(),
        alimentacionUsecase: locator(),
        alimentacionUsecaseDB: locator(),
        cigarrilloDiaUsecase: locator(),
        cigarrilloDiaUsecaseDB: locator(),
        consumoAlcoholUsecase: locator(),
        consumoAlcoholUsecaseDB: locator(),
        condicionNutricionalUsecase: locator(),
        condicionNutricionalUsecaseDB: locator(),
        conductaSeguirUsecase: locator(),
        conductaSeguirUsecaseDB: locator(),
        esquemaVacunacionUsecase: locator(),
        esquemaVacunacionUsecaseDB: locator(),
        lugarVacunacionUsecase: locator(),
        lugarVacunacionUsecaseDB: locator(),
        metodoPlanificacionUsecase: locator(),
        metodoPlanificacionUsecaseDB: locator(),
        nombreEnfermedadUsecase: locator(),
        nombreEnfermedadUsecaseDB: locator(),
        seguimientoEnfermedadUsecase: locator(),
        seguimientoEnfermedadUsecaseDB: locator(),
        servicioSolicitadoUsecase: locator(),
        servicioSolicitadoUsecaseDB: locator(),
        ultimaVezInstSaludUsecase: locator(),
        ultimaVezInstSaludUsecaseDB: locator(),
        enfermedadAcudeUsecase: locator(),
        enfermedadAcudeUsecaseDB: locator(),
        enfermedadTradicionalUsecase: locator(),
        enfermedadTradicionalUsecaseDB: locator(),
        enfermedadTratamientoUsecase: locator(),
        enfermedadTratamientoUsecaseDB: locator(),
        lugarAtencionMedicoUsecase: locator(),
        lugarAtencionMedicoUsecaseDB: locator(),
        lugarPlantaMedicinalUsecase: locator(),
        lugarPlantaMedicinalUsecaseDB: locator(),
        plantaMedicinalUsecase: locator(),
        plantaMedicinalUsecaseDB: locator(),
        costumbrePracticaUsecase: locator(),
        costumbrePracticaUsecaseDB: locator(),
        eventoCostumbreParticipaUsecase: locator(),
        eventoCostumbreParticipaUsecaseDB: locator(),
        religionProfesaUsecase: locator(),
        religionProfesaUsecaseDB: locator(),
        sancionJusticiaUsecase: locator(),
        sancionJusticiaUsecaseDB: locator(),
        fichaUsecase: locator(),
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
      verduraUsecaseDB: locator()));

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
      presenciaAnimalViviendaUsecaseDB: locator()));

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

void cerealInit() {
  // cubit
  locator.registerFactory(() => CerealCubit(
        cerealUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => CerealUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => CerealUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<CerealRepository>(
    () => CerealRepositoryImpl(
      cerealRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<CerealRepositoryDB>(
    () => CerealRepositoryDBImpl(
      cerealLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<CerealRemoteDataSource>(
    () => CerealRemoteDataSourceImpl(
      client: locator(),
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

void dificultadAccesoMedTradicionalInit() {
  // cubit
  locator.registerFactory(() => DificultadAccesoMedTradicionalCubit(
        dificultadAccesoMedTradicionalUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(
      () => DificultadAccesoMedTradicionalUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => DificultadAccesoMedTradicionalUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<DificultadAccesoMedTradicionalRepository>(
    () => DificultadAccesoMedTradicionalRepositoryImpl(
      dificultadAccesoMedTradicionalRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<DificultadAccesoMedTradicionalRepositoryDB>(
    () => DificultadAccesoMedTradicionalRepositoryDBImpl(
      dificultadAccesoMedTradicionalLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<DificultadAccesoMedTradicionalRemoteDataSource>(
    () => DificultadAccesoMedTradicionalRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(
      () => EspecialidadMedTradicionalUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => EspecialidadMedTradicionalUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EspecialidadMedTradicionalRepository>(
    () => EspecialidadMedTradicionalRepositoryImpl(
      especialidadMedTradicionalRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EspecialidadMedTradicionalRepositoryDB>(
    () => EspecialidadMedTradicionalRepositoryDBImpl(
      especialidadMedTradicionalLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EspecialidadMedTradicionalRemoteDataSource>(
    () => EspecialidadMedTradicionalRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => EspecieAnimalUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => EspecieAnimalUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EspecieAnimalRepository>(
    () => EspecieAnimalRepositoryImpl(
      especieAnimalRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EspecieAnimalRepositoryDB>(
    () => EspecieAnimalRepositoryDBImpl(
      especieAnimalLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EspecieAnimalRemoteDataSource>(
    () => EspecieAnimalRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => FrutoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => FrutoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<FrutoRepository>(
    () => FrutoRepositoryImpl(
      frutoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<FrutoRepositoryDB>(
    () => FrutoRepositoryDBImpl(
      frutoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<FrutoRemoteDataSource>(
    () => FrutoRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => HortalizaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => HortalizaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<HortalizaRepository>(
    () => HortalizaRepositoryImpl(
      hortalizaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<HortalizaRepositoryDB>(
    () => HortalizaRepositoryDBImpl(
      hortalizaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<HortalizaRemoteDataSource>(
    () => HortalizaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => LeguminosaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => LeguminosaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<LeguminosaRepository>(
    () => LeguminosaRepositoryImpl(
      leguminosaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<LeguminosaRepositoryDB>(
    () => LeguminosaRepositoryDBImpl(
      leguminosaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<LeguminosaRemoteDataSource>(
    () => LeguminosaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(
      () => MedioUtilizaMedTradicionalUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => MedioUtilizaMedTradicionalUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<MedioUtilizaMedTradicionalRepository>(
    () => MedioUtilizaMedTradicionalRepositoryImpl(
      medioUtilizaMedTradicionalRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<MedioUtilizaMedTradicionalRepositoryDB>(
    () => MedioUtilizaMedTradicionalRepositoryDBImpl(
      medioUtilizaMedTradicionalLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<MedioUtilizaMedTradicionalRemoteDataSource>(
    () => MedioUtilizaMedTradicionalRemoteDataSourceImpl(
      client: locator(),
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
  locator.registerFactory(() => ResguardoCubit(
        resguardoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => ResguardoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ResguardoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ResguardoRepository>(
    () => ResguardoRepositoryImpl(
      resguardoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ResguardoRepositoryDB>(
    () => ResguardoRepositoryDBImpl(
      resguardoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ResguardoRemoteDataSource>(
    () => ResguardoRemoteDataSourceImpl(
      client: locator(),
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

void tuberculoPlatanoInit() {
  // cubit
  locator.registerFactory(() => TuberculoPlatanoCubit(
        tuberculoPlatanoUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => TuberculoPlatanoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TuberculoPlatanoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TuberculoPlatanoRepository>(
    () => TuberculoPlatanoRepositoryImpl(
      tuberculoPlatanoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TuberculoPlatanoRepositoryDB>(
    () => TuberculoPlatanoRepositoryDBImpl(
      tuberculoPlatanoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TuberculoPlatanoRemoteDataSource>(
    () => TuberculoPlatanoRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => VerduraUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => VerduraUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<VerduraRepository>(
    () => VerduraRepositoryImpl(
      verduraRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<VerduraRepositoryDB>(
    () => VerduraRepositoryDBImpl(
      verduraLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<VerduraRemoteDataSource>(
    () => VerduraRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => FactorRiesgoViviendaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => FactorRiesgoViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<FactorRiesgoViviendaRepository>(
    () => FactorRiesgoViviendaRepositoryImpl(
      factorRiesgoViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<FactorRiesgoViviendaRepositoryDB>(
    () => FactorRiesgoViviendaRepositoryDBImpl(
      factorRiesgoViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<FactorRiesgoViviendaRemoteDataSource>(
    () => FactorRiesgoViviendaRemoteDataSourceImpl(
      client: locator(),
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

void pisoViviendaInit() {
  // cubit
  locator.registerFactory(() => PisoViviendaCubit(
        pisoViviendaUsecaseDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => PisoViviendaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => PisoViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PisoViviendaRepository>(
    () => PisoViviendaRepositoryImpl(
      pisoViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PisoViviendaRepositoryDB>(
    () => PisoViviendaRepositoryDBImpl(
      pisoViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PisoViviendaRemoteDataSource>(
    () => PisoViviendaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator
      .registerLazySingleton(() => PresenciaAnimalViviendaUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => PresenciaAnimalViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PresenciaAnimalViviendaRepository>(
    () => PresenciaAnimalViviendaRepositoryImpl(
      presenciaAnimalViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PresenciaAnimalViviendaRepositoryDB>(
    () => PresenciaAnimalViviendaRepositoryDBImpl(
      presenciaAnimalViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PresenciaAnimalViviendaRemoteDataSource>(
    () => PresenciaAnimalViviendaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator
      .registerLazySingleton(() => ServicioPublicoViviendaUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => ServicioPublicoViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ServicioPublicoViviendaRepository>(
    () => ServicioPublicoViviendaRepositoryImpl(
      servicioPublicoViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ServicioPublicoViviendaRepositoryDB>(
    () => ServicioPublicoViviendaRepositoryDBImpl(
      servicioPublicoViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ServicioPublicoViviendaRemoteDataSource>(
    () => ServicioPublicoViviendaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => TechoViviendaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TechoViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TechoViviendaRepository>(
    () => TechoViviendaRepositoryImpl(
      techoViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TechoViviendaRepositoryDB>(
    () => TechoViviendaRepositoryDBImpl(
      techoViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TechoViviendaRemoteDataSource>(
    () => TechoViviendaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => TenenciaViviendaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TenenciaViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TenenciaViviendaRepository>(
    () => TenenciaViviendaRepositoryImpl(
      tenenciaViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TenenciaViviendaRepositoryDB>(
    () => TenenciaViviendaRepositoryDBImpl(
      tenenciaViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TenenciaViviendaRemoteDataSource>(
    () => TenenciaViviendaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator
      .registerLazySingleton(() => TipoCombustibleViviendaUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => TipoCombustibleViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoCombustibleViviendaRepository>(
    () => TipoCombustibleViviendaRepositoryImpl(
      tipoCombustibleViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoCombustibleViviendaRepositoryDB>(
    () => TipoCombustibleViviendaRepositoryDBImpl(
      tipoCombustibleViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoCombustibleViviendaRemoteDataSource>(
    () => TipoCombustibleViviendaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => TipoSanitarioViviendaUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => TipoSanitarioViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoSanitarioViviendaRepository>(
    () => TipoSanitarioViviendaRepositoryImpl(
      tipoSanitarioViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoSanitarioViviendaRepositoryDB>(
    () => TipoSanitarioViviendaRepositoryDBImpl(
      tipoSanitarioViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoSanitarioViviendaRemoteDataSource>(
    () => TipoSanitarioViviendaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => TipoViviendaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoViviendaRepository>(
    () => TipoViviendaRepositoryImpl(
      tipoViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoViviendaRepositoryDB>(
    () => TipoViviendaRepositoryDBImpl(
      tipoViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoViviendaRemoteDataSource>(
    () => TipoViviendaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator
      .registerLazySingleton(() => TratamientoAguaViviendaUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => TratamientoAguaViviendaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TratamientoAguaViviendaRepository>(
    () => TratamientoAguaViviendaRepositoryImpl(
      tratamientoAguaViviendaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TratamientoAguaViviendaRepositoryDB>(
    () => TratamientoAguaViviendaRepositoryDBImpl(
      tratamientoAguaViviendaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TratamientoAguaViviendaRemoteDataSource>(
    () => TratamientoAguaViviendaRemoteDataSourceImpl(
      client: locator(),
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

void cursoVidaInit() {
  // cubit
  locator.registerFactory(() => CursoVidaCubit(cursoVidaUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => CursoVidaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => CursoVidaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<CursoVidaRepository>(
    () => CursoVidaRepositoryImpl(
      cursoVidaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<CursoVidaRepositoryDB>(
    () => CursoVidaRepositoryDBImpl(
      cursoVidaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<CursoVidaRemoteDataSource>(
    () => CursoVidaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => EtniaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => EtniaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EtniaRepository>(
    () => EtniaRepositoryImpl(
      etniaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EtniaRepositoryDB>(
    () => EtniaRepositoryDBImpl(
      etniaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EtniaRemoteDataSource>(
    () => EtniaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => GeneroUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => GeneroUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<GeneroRepository>(
    () => GeneroRepositoryImpl(
      generoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<GeneroRepositoryDB>(
    () => GeneroRepositoryDBImpl(
      generoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<GeneroRemoteDataSource>(
    () => GeneroRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => GrupoRiesgoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => GrupoRiesgoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<GrupoRiesgoRepository>(
    () => GrupoRiesgoRepositoryImpl(
      grupoRiesgoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<GrupoRiesgoRepositoryDB>(
    () => GrupoRiesgoRepositoryDBImpl(
      grupoRiesgoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<GrupoRiesgoRemoteDataSource>(
    () => GrupoRiesgoRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => LenguaManejaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => LenguaManejaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<LenguaManejaRepository>(
    () => LenguaManejaRepositoryImpl(
      lenguaManejaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<LenguaManejaRepositoryDB>(
    () => LenguaManejaRepositoryDBImpl(
      lenguaManejaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<LenguaManejaRemoteDataSource>(
    () => LenguaManejaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => NivelEducativoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => NivelEducativoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<NivelEducativoRepository>(
    () => NivelEducativoRepositoryImpl(
      nivelEducativoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<NivelEducativoRepositoryDB>(
    () => NivelEducativoRepositoryDBImpl(
      nivelEducativoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<NivelEducativoRemoteDataSource>(
    () => NivelEducativoRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => NombreLenguaMaternaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => NombreLenguaMaternaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<NombreLenguaMaternaRepository>(
    () => NombreLenguaMaternaRepositoryImpl(
      nombreLenguaMaternaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<NombreLenguaMaternaRepositoryDB>(
    () => NombreLenguaMaternaRepositoryDBImpl(
      nombreLenguaMaternaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<NombreLenguaMaternaRemoteDataSource>(
    () => NombreLenguaMaternaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => OcupacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => OcupacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<OcupacionRepository>(
    () => OcupacionRepositoryImpl(
      ocupacionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<OcupacionRepositoryDB>(
    () => OcupacionRepositoryDBImpl(
      ocupacionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<OcupacionRemoteDataSource>(
    () => OcupacionRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => ParentescoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ParentescoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ParentescoRepository>(
    () => ParentescoRepositoryImpl(
      parentescoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ParentescoRepositoryDB>(
    () => ParentescoRepositoryDBImpl(
      parentescoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ParentescoRemoteDataSource>(
    () => ParentescoRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => PuebloIndigenaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => PuebloIndigenaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PuebloIndigenaRepository>(
    () => PuebloIndigenaRepositoryImpl(
      puebloIndigenaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PuebloIndigenaRepositoryDB>(
    () => PuebloIndigenaRepositoryDBImpl(
      puebloIndigenaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PuebloIndigenaRemoteDataSource>(
    () => PuebloIndigenaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PuebloIndigenaLocalDataSource>(
    () => PuebloIndigenaLocalDataSourceImpl(),
  );
}

void regimenInit() {
  // cubit
  locator.registerFactory(() => RegimenCubit(regimenUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => RegimenUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => RegimenUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<RegimenRepository>(
    () => RegimenRepositoryImpl(
      regimenRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<RegimenRepositoryDB>(
    () => RegimenRepositoryDBImpl(
      regimenLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<RegimenRemoteDataSource>(
    () => RegimenRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<RegimenLocalDataSource>(
    () => RegimenLocalDataSourceImpl(),
  );
}

void tipoDocumentoInit() {
  // cubit
  locator.registerFactory(
      () => TipoDocumentoCubit(tipoDocumentoUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => TipoDocumentoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoDocumentoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoDocumentoRepository>(
    () => TipoDocumentoRepositoryImpl(
      tipoDocumentoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoDocumentoRepositoryDB>(
    () => TipoDocumentoRepositoryDBImpl(
      tipoDocumentoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoDocumentoRemoteDataSource>(
    () => TipoDocumentoRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => ActividadFisicaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ActividadFisicaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ActividadFisicaRepository>(
    () => ActividadFisicaRepositoryImpl(
      actividadFisicaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ActividadFisicaRepositoryDB>(
    () => ActividadFisicaRepositoryDBImpl(
      actividadFisicaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ActividadFisicaRemoteDataSource>(
    () => ActividadFisicaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => AlimentacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => AlimentacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AlimentacionRepository>(
    () => AlimentacionRepositoryImpl(
      alimentacionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AlimentacionRepositoryDB>(
    () => AlimentacionRepositoryDBImpl(
      alimentacionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AlimentacionRemoteDataSource>(
    () => AlimentacionRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => CigarrilloDiaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => CigarrilloDiaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<CigarrilloDiaRepository>(
    () => CigarrilloDiaRepositoryImpl(
      cigarrilloDiaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<CigarrilloDiaRepositoryDB>(
    () => CigarrilloDiaRepositoryDBImpl(
      cigarrilloDiaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<CigarrilloDiaRemoteDataSource>(
    () => CigarrilloDiaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => ConsumoAlcoholUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ConsumoAlcoholUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ConsumoAlcoholRepository>(
    () => ConsumoAlcoholRepositoryImpl(
      consumoAlcoholRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ConsumoAlcoholRepositoryDB>(
    () => ConsumoAlcoholRepositoryDBImpl(
      consumoAlcoholLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ConsumoAlcoholRemoteDataSource>(
    () => ConsumoAlcoholRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => CondicionNutricionalUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => CondicionNutricionalUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<CondicionNutricionalRepository>(
    () => CondicionNutricionalRepositoryImpl(
      condicionNutricionalRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<CondicionNutricionalRepositoryDB>(
    () => CondicionNutricionalRepositoryDBImpl(
      condicionNutricionalLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<CondicionNutricionalRemoteDataSource>(
    () => CondicionNutricionalRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => ConductaSeguirUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ConductaSeguirUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ConductaSeguirRepository>(
    () => ConductaSeguirRepositoryImpl(
      conductaSeguirRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ConductaSeguirRepositoryDB>(
    () => ConductaSeguirRepositoryDBImpl(
      conductaSeguirLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ConductaSeguirRemoteDataSource>(
    () => ConductaSeguirRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => EsquemaVacunacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => EsquemaVacunacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EsquemaVacunacionRepository>(
    () => EsquemaVacunacionRepositoryImpl(
      esquemaVacunacionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EsquemaVacunacionRepositoryDB>(
    () => EsquemaVacunacionRepositoryDBImpl(
      esquemaVacunacionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EsquemaVacunacionRemoteDataSource>(
    () => EsquemaVacunacionRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => LugarVacunacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => LugarVacunacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<LugarVacunacionRepository>(
    () => LugarVacunacionRepositoryImpl(
      lugarVacunacionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<LugarVacunacionRepositoryDB>(
    () => LugarVacunacionRepositoryDBImpl(
      lugarVacunacionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<LugarVacunacionRemoteDataSource>(
    () => LugarVacunacionRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<LugarVacunacionLocalDataSource>(
    () => LugarVacunacionLocalDataSourceImpl(),
  );
}

void metodoPlanificacionInit() {
  // cubit
  locator.registerFactory(
      () => MetodoPlanificacionCubit(metodoPlanificacionUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => MetodoPlanificacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => MetodoPlanificacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<MetodoPlanificacionRepository>(
    () => MetodoPlanificacionRepositoryImpl(
      metodoPlanificacionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<MetodoPlanificacionRepositoryDB>(
    () => MetodoPlanificacionRepositoryDBImpl(
      metodoPlanificacionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<MetodoPlanificacionRemoteDataSource>(
    () => MetodoPlanificacionRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => NombreEnfermedadUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => NombreEnfermedadUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<NombreEnfermedadRepository>(
    () => NombreEnfermedadRepositoryImpl(
      nombreEnfermedadRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<NombreEnfermedadRepositoryDB>(
    () => NombreEnfermedadRepositoryDBImpl(
      nombreEnfermedadLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<NombreEnfermedadRemoteDataSource>(
    () => NombreEnfermedadRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => SeguimientoEnfermedadUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => SeguimientoEnfermedadUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<SeguimientoEnfermedadRepository>(
    () => SeguimientoEnfermedadRepositoryImpl(
      seguimientoEnfermedadRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<SeguimientoEnfermedadRepositoryDB>(
    () => SeguimientoEnfermedadRepositoryDBImpl(
      seguimientoEnfermedadLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<SeguimientoEnfermedadRemoteDataSource>(
    () => SeguimientoEnfermedadRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => ServicioSolicitadoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ServicioSolicitadoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ServicioSolicitadoRepository>(
    () => ServicioSolicitadoRepositoryImpl(
      servicioSolicitadoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ServicioSolicitadoRepositoryDB>(
    () => ServicioSolicitadoRepositoryDBImpl(
      servicioSolicitadoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ServicioSolicitadoRemoteDataSource>(
    () => ServicioSolicitadoRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => UltimaVezInstSaludUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => UltimaVezInstSaludUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<UltimaVezInstSaludRepository>(
    () => UltimaVezInstSaludRepositoryImpl(
      ultimaVezInstSaludRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<UltimaVezInstSaludRepositoryDB>(
    () => UltimaVezInstSaludRepositoryDBImpl(
      ultimaVezInstSaludLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<UltimaVezInstSaludRemoteDataSource>(
    () => UltimaVezInstSaludRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => EnfermedadAcudeUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => EnfermedadAcudeUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EnfermedadAcudeRepository>(
    () => EnfermedadAcudeRepositoryImpl(
      enfermedadAcudeRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EnfermedadAcudeRepositoryDB>(
    () => EnfermedadAcudeRepositoryDBImpl(
      enfermedadAcudeLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EnfermedadAcudeRemoteDataSource>(
    () => EnfermedadAcudeRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => EnfermedadTratamientoUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => EnfermedadTratamientoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EnfermedadTratamientoRepository>(
    () => EnfermedadTratamientoRepositoryImpl(
      enfermedadTratamientoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EnfermedadTratamientoRepositoryDB>(
    () => EnfermedadTratamientoRepositoryDBImpl(
      enfermedadTratamientoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EnfermedadTratamientoRemoteDataSource>(
    () => EnfermedadTratamientoRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => EnfermedadTradicionalUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => EnfermedadTradicionalUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EnfermedadTradicionalRepository>(
    () => EnfermedadTradicionalRepositoryImpl(
      enfermedadTradicionalRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EnfermedadTradicionalRepositoryDB>(
    () => EnfermedadTradicionalRepositoryDBImpl(
      enfermedadTradicionalLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EnfermedadTradicionalRemoteDataSource>(
    () => EnfermedadTradicionalRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => LugarAtencionMedicoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => LugarAtencionMedicoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<LugarAtencionMedicoRepository>(
    () => LugarAtencionMedicoRepositoryImpl(
      lugarAtencionMedicoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<LugarAtencionMedicoRepositoryDB>(
    () => LugarAtencionMedicoRepositoryDBImpl(
      lugarAtencionMedicoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<LugarAtencionMedicoRemoteDataSource>(
    () => LugarAtencionMedicoRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => LugarPlantaMedicinalUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => LugarPlantaMedicinalUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<LugarPlantaMedicinalRepository>(
    () => LugarPlantaMedicinalRepositoryImpl(
      lugarPlantaMedicinalRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<LugarPlantaMedicinalRepositoryDB>(
    () => LugarPlantaMedicinalRepositoryDBImpl(
      lugarPlantaMedicinalLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<LugarPlantaMedicinalRemoteDataSource>(
    () => LugarPlantaMedicinalRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => PlantaMedicinalUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => PlantaMedicinalUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PlantaMedicinalRepository>(
    () => PlantaMedicinalRepositoryImpl(
      plantaMedicinalRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PlantaMedicinalRepositoryDB>(
    () => PlantaMedicinalRepositoryDBImpl(
      plantaMedicinalLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PlantaMedicinalRemoteDataSource>(
    () => PlantaMedicinalRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => ReligionProfesaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ReligionProfesaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ReligionProfesaRepository>(
    () => ReligionProfesaRepositoryImpl(
      religionProfesaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ReligionProfesaRepositoryDB>(
    () => ReligionProfesaRepositoryDBImpl(
      religionProfesaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ReligionProfesaRemoteDataSource>(
    () => ReligionProfesaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator
      .registerLazySingleton(() => EventoCostumbreParticipaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => EventoCostumbreParticipaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EventoCostumbreParticipaRepository>(
    () => EventoCostumbreParticipaRepositoryImpl(
      eventoCostumbreParticipaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EventoCostumbreParticipaRepositoryDB>(
    () => EventoCostumbreParticipaRepositoryDBImpl(
      eventoCostumbreParticipaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EventoCostumbreParticipaRemoteDataSource>(
    () => EventoCostumbreParticipaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => CostumbrePracticaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => CostumbrePracticaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<CostumbrePracticaRepository>(
    () => CostumbrePracticaRepositoryImpl(
      costumbrePracticaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<CostumbrePracticaRepositoryDB>(
    () => CostumbrePracticaRepositoryDBImpl(
      costumbrePracticaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<CostumbrePracticaRemoteDataSource>(
    () => CostumbrePracticaRemoteDataSourceImpl(
      client: locator(),
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

  // remote usecase
  locator.registerLazySingleton(() => SancionJusticiaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => SancionJusticiaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<SancionJusticiaRepository>(
    () => SancionJusticiaRepositoryImpl(
      sancionJusticiaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<SancionJusticiaRepositoryDB>(
    () => SancionJusticiaRepositoryDBImpl(
      sancionJusticiaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<SancionJusticiaRemoteDataSource>(
    () => SancionJusticiaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<SancionJusticiaLocalDataSource>(
    () => SancionJusticiaLocalDataSourceImpl(),
  );
}
