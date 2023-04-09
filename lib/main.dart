import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;
import 'router.dart';
import 'ui/blocs/afiliado/afiliado_bloc.dart';
import 'ui/blocs/auth/auth_bloc.dart';
import 'ui/blocs/sync/sync_bloc.dart';
import 'ui/cubits/dificultad_acceso_ca/dificultad_acceso_ca_cubit.dart';
import 'ui/cubits/estado_via/estado_via_cubit.dart';
import 'ui/cubits/internet/internet_cubit.dart';
import 'ui/cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import 'ui/cubits/medio_utiliza_ca/medio_utiliza_ca_cubit.dart';
import 'ui/cubits/sync_log/sync_log_cubit.dart';
import 'ui/cubits/tiempo_tarda_ca/tiempo_tarda_ca_cubit.dart';
import 'ui/cubits/via_acceso/via_acceso_cubit.dart';
import 'ui/utils/styles.dart';

void main() {
  di.init();
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
