import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';
import 'injection.dart' as di;
import 'router.dart';
import 'ui/blocs/afiliado/afiliado_bloc.dart';
import 'ui/blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import 'ui/blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import 'ui/blocs/atencion_salud/atencion_salud_bloc.dart';
import 'ui/blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';
import 'ui/blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import 'ui/blocs/auth/auth_bloc.dart';
import 'ui/blocs/dim_vivienda/dim_vivienda_bloc.dart';
import 'ui/blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';
import 'ui/blocs/encuesta/encuesta_bloc.dart';
import 'ui/blocs/estilo_vida_saludable/estilo_vida_saludable_bloc.dart';
import 'ui/blocs/familia/familia_bloc.dart';
import 'ui/blocs/ficha/ficha_bloc.dart';
import 'ui/blocs/grupo_familiar/grupo_familiar_bloc.dart';
import 'ui/blocs/sync/sync_bloc.dart';
import 'ui/cubits/actividad_fisica/actividad_fisica_cubit.dart';
import 'ui/cubits/alimentacion/alimentacion_cubit.dart';
import 'ui/cubits/autoridad_indigena/autoridad_indigena_cubit.dart';
import 'ui/cubits/cereal_by_dpto/cereal_by_dpto_cubit.dart';
import 'ui/cubits/cigarrillo_dia/cigarrillo_dia_cubit.dart';
import 'ui/cubits/condicion_nutricional/condicion_nutricional_cubit.dart';
import 'ui/cubits/conducta_seguir/conducta_seguir_cubit.dart';
import 'ui/cubits/consumo_alcohol/consumo_alcohol_cubit.dart';
import 'ui/cubits/costo_desplazamiento/costo_desplazamiento_cubit.dart';
import 'ui/cubits/costumbre_practica/costumbre_practica_cubit.dart';
import 'ui/cubits/curso_vida/curso_vida_cubit.dart';
import 'ui/cubits/dificultad_acceso_ca/dificultad_acceso_ca_cubit.dart';
import 'ui/cubits/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_cubit.dart';
import 'ui/cubits/enfermedad_acude/enfermedad_acude_cubit.dart';
import 'ui/cubits/enfermedad_tradicional/enfermedad_tradicional_cubit.dart';
import 'ui/cubits/enfermedad_tratamiento/enfermedad_tratamiento_cubit.dart';
import 'ui/cubits/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_cubit.dart';
import 'ui/cubits/especie_animal_by_dpto/especie_animal_by_dpto_cubit.dart';
import 'ui/cubits/esquema_vacunacion/esquema_vacunacion_cubit.dart';
import 'ui/cubits/estado_via/estado_via_cubit.dart';
import 'ui/cubits/etnia/etnia_cubit.dart';
import 'ui/cubits/evento_costumbre_participa/evento_costumbre_participa_cubit.dart';
import 'ui/cubits/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_cubit.dart';
import 'ui/cubits/familia/familia_cubit.dart';
import 'ui/cubits/ficha/ficha_cubit.dart';
import 'ui/cubits/fruto_by_dpto/fruto_by_dpto_cubit.dart';
import 'ui/cubits/genero/genero_cubit.dart';
import 'ui/cubits/grupo_riesgo/grupo_riesgo_cubit.dart';
import 'ui/cubits/hortaliza_by_dpto/hortaliza_by_dpto_cubit.dart';
import 'ui/cubits/iluminacion_vivienda/iluminacion_vivienda_cubit.dart';
import 'ui/cubits/internet/internet_cubit.dart';
import 'ui/cubits/leguminosa_by_dpto/leguminosa_by_dpto_cubit.dart';
import 'ui/cubits/lengua_maneja/lengua_maneja_cubit.dart';
import 'ui/cubits/lugar_atencion_medico/lugar_atencion_medico_cubit.dart';
import 'ui/cubits/lugar_planta_medicinal/lugar_planta_medicinal_cubit.dart';
import 'ui/cubits/lugar_vacunacion/lugar_vacunacion_cubit.dart';
import 'ui/cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import 'ui/cubits/medio_utiliza_ca/medio_utiliza_ca_cubit.dart';
import 'ui/cubits/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_cubit.dart';
import 'ui/cubits/metodo_planificacion/metodo_planificacion_cubit.dart';
import 'ui/cubits/nivel_educativo/nivel_educativo_cubit.dart';
import 'ui/cubits/nombre_enfermedad/nombre_enfermedad_cubit.dart';
import 'ui/cubits/nombre_lengua_materna/nombre_lengua_materna_cubit.dart';
import 'ui/cubits/ocupacion/ocupacion_cubit.dart';
import 'ui/cubits/opcion_si_no/opcion_si_no_cubit.dart';
import 'ui/cubits/parentesco/parentesco_cubit.dart';
import 'ui/cubits/piso_vivienda_by_dpto/piso_vivienda_by_dpto_cubit.dart';
import 'ui/cubits/planta_medicinal/planta_medicinal_cubit.dart';
import 'ui/cubits/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_cubit.dart';
import 'ui/cubits/pueblo_indigena_by_dpto/pueblo_indigena_by_dpto_cubit.dart';
import 'ui/cubits/regimen/regimen_cubit.dart';
import 'ui/cubits/religion_profesa/religion_profesa_cubit.dart';
import 'ui/cubits/resguardo_by_dpto/resguardo_by_dpto_cubit.dart';
import 'ui/cubits/sancion_justicia/sancion_justicia_cubit.dart';
import 'ui/cubits/seguimiento_enfermedad/seguimiento_enfermedad_cubit.dart';
import 'ui/cubits/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_cubit.dart';
import 'ui/cubits/servicio_solicitado/servicio_solicitado_cubit.dart';
import 'ui/cubits/sync_log/sync_log_cubit.dart';
import 'ui/cubits/techo_vivienda_by_dpto/techo_vivienda_by_dpto_cubit.dart';
import 'ui/cubits/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_cubit.dart';
import 'ui/cubits/tiempo_tarda_ca/tiempo_tarda_ca_cubit.dart';
import 'ui/cubits/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_cubit.dart';
import 'ui/cubits/tipo_calendario/tipo_calendario_cubit.dart';
import 'ui/cubits/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_cubit.dart';
import 'ui/cubits/tipo_documento/tipo_documento_cubit.dart';
import 'ui/cubits/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_cubit.dart';
import 'ui/cubits/tipo_vivienda_by_dpto/tipo_vivienda_by_dpto_cubit.dart';
import 'ui/cubits/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_cubit.dart';
import 'ui/cubits/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_cubit.dart';
import 'ui/cubits/ultima_vez_inst_salud/ultima_vez_inst_salud_cubit.dart';
import 'ui/cubits/ventilacion_vivienda/ventilacion_vivienda_cubit.dart';
import 'ui/cubits/verdura_by_dpto/verdura_by_dpto_cubit.dart';
import 'ui/cubits/via_acceso/via_acceso_cubit.dart';
import 'ui/utils/styles.dart';

final prefs = SharedPreferencesService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await prefs.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<InternetCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AuthBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SyncBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SyncLogCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AfiliadoBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AfiliadoPrefsBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DimUbicacionBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DimViviendaBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EncuestaBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AfiliadosGrupoFamiliarBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<GrupoFamiliarBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EstiloVidaSaludableBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<CuidadoSaludCondRiesgoBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AtencionSaludBloc>(),
          ),
          BlocProvider(
            create: (_) =>
                di.locator<DimensionSocioculturalPueblosIndigenasBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DificultadAccesoCACubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EstadoViaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MedioComunicacionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MedioUtilizaCACubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TiempoTardaCACubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ViaAccesoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AutoridadIndigenaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<CerealByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<CostoDesplazamientoCubit>(),
          ),
          BlocProvider(
            create: (_) =>
                di.locator<DificultadAccesoMedTradicionalByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EspecialidadMedTradicionalCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EspecieAnimalByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<FrutoByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<HortalizaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<LeguminosaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MedioUtilizaMedTradicionalByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<OpcionSiNoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ResguardoByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TiempoTardaMedTradicionalCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TuberculoPlatanoByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<VerduraByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<FactorRiesgoViviendaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<IluminacionViviendaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PisoViviendaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PresenciaAnimalViviendaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ServicioPublicoViviendaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TechoViviendaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TenenciaViviendaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoCombustibleViviendaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoSanitarioViviendaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoViviendaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TratamientoAguaViviendaByDptoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<VentilacionViviendaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoCalendarioCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<FichaBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<FichaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<FamiliaBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<FamiliaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<CursoVidaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EtniaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<GeneroCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<GrupoRiesgoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<LenguaManejaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<NivelEducativoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<NombreLenguaMaternaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<OcupacionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ParentescoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PuebloIndigenaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<RegimenCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoDocumentoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ActividadFisicaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AlimentacionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<CigarrilloDiaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ConsumoAlcoholCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<CondicionNutricionalCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ConductaSeguirCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EsquemaVacunacionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<LugarVacunacionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MetodoPlanificacionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<NombreEnfermedadCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SeguimientoEnfermedadCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ServicioSolicitadoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<UltimaVezInstSaludCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EnfermedadAcudeCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EnfermedadTratamientoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EnfermedadTradicionalCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<LugarAtencionMedicoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<LugarPlantaMedicinalCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PlantaMedicinalCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ReligionProfesaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EventoCostumbreParticipaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<CostumbrePracticaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SancionJusticiaCubit>(),
          ),
        ],
        child: MaterialApp(
            title: 'IFASORIS',
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.initialRoute,
            routes: AppRouter.routes,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Styles.lightGreen,
                    secondary: Styles.obscureGreen))));
  }
}
