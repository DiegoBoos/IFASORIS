import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';
import 'injection.dart' as di;
import 'router.dart';
import 'ui/blocs/afiliado/afiliado_bloc.dart';
import 'ui/blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import 'ui/blocs/auth/auth_bloc.dart';
import 'ui/blocs/familia/familia_bloc.dart';
import 'ui/blocs/ficha/ficha_bloc.dart';
import 'ui/blocs/grupo_familiar/grupo_familiar_bloc.dart';
import 'ui/blocs/sync/sync_bloc.dart';
import 'ui/cubits/autoridad_indigena/autoridad_indigena_cubit.dart';
import 'ui/cubits/cereal_by_dpto/cereal_by_dpto_cubit.dart';
import 'ui/cubits/costo_desplazamiento/costo_desplazamiento_cubit.dart';
import 'ui/cubits/dificultad_acceso_ca/dificultad_acceso_ca_cubit.dart';
import 'ui/cubits/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_cubit.dart';
import 'ui/cubits/dim_ubicacion/dim_ubicacion_state.dart';
import 'ui/cubits/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_cubit.dart';
import 'ui/cubits/especie_animal_by_dpto/especie_animal_by_dpto_cubit.dart';
import 'ui/cubits/estado_via/estado_via_cubit.dart';
import 'ui/cubits/familia/familia_cubit.dart';
import 'ui/cubits/ficha/ficha_cubit.dart';
import 'ui/cubits/fruto_by_dpto/fruto_by_dpto_cubit.dart';
import 'ui/cubits/hortaliza_by_dpto/hortaliza_by_dpto_cubit.dart';
import 'ui/cubits/internet/internet_cubit.dart';
import 'ui/cubits/leguminosa_by_dpto/leguminosa_by_dpto_cubit.dart';
import 'ui/cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import 'ui/cubits/medio_utiliza_ca/medio_utiliza_ca_cubit.dart';
import 'ui/cubits/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_cubit.dart';
import 'ui/cubits/opcion_si_no/opcion_si_no_cubit.dart';
import 'ui/cubits/resguardo_by_dpto/resguardo_by_dpto_cubit.dart';
import 'ui/cubits/sync_log/sync_log_cubit.dart';
import 'ui/cubits/tiempo_tarda_ca/tiempo_tarda_ca_cubit.dart';
import 'ui/cubits/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_cubit.dart';
import 'ui/cubits/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_cubit.dart';
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
            create: (_) => di.locator<EspecialidadMedTradicionalByDptoCubit>(),
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
            create: (_) => di.locator<AfiliadoPrefsBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DimUbicacionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<GrupoFamiliarBloc>(),
          ),
        ],
        child: MaterialApp(
            title: 'IFASORIS',
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.initialRoute,
            routes: AppRouter.routes,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Styles.lightGreen,
                    secondary: Styles.obscureGreen))));
  }
}
