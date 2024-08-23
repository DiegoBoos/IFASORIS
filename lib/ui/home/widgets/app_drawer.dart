import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/core/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/ficha/ficha_bloc.dart';
import '../../blocs/sync/sync_bloc.dart';
import '../pages/graficas_page.dart';
import 'sync_status.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final fichaBloc = BlocProvider.of<FichaBloc>(context);
    final user = supabase.auth.currentUser!;

    return Drawer(
      elevation: 16.0,
      semanticLabel: 'App Drawer',
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    user.userMetadata!['UserName'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  BlocBuilder<AfiliadoPrefsBloc, AfiliadoPrefsState>(
                    builder: (context, state) {
                      if (state is AfiliadoLoaded) {
                        return Text(
                            'AFILIADO: ${state.afiliado?.nombre1 ?? ''} ${state.afiliado?.nombre2 ?? ''} ${state.afiliado?.apellido1 ?? ''} ${state.afiliado?.apellido2 ?? ''}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ));
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.cloud_download),
              title: const Text('Sincronización (Descarga)'),
              onTap: () {
                Navigator.pop(context);
                comenzarSincronizacion(context, user, 'A');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.cloud_upload),
              title: const Text('Sincronización (Subida)'),
              onTap: () {
                Navigator.pop(context);
                comenzarSincronizacion(context, user, 'P');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.pie_chart),
              title: const Text('Estadísticas'),
              onTap: () async {
                await fichaBloc.loadEstadisticas().then((estadisticas) {
                  final registradas = estadisticas
                      .where((i) => i.estadistica == 'FichasRegistradas')
                      .first;
                  final reportadas = estadisticas
                      .where((i) => i.estadistica == 'FichasReportadas')
                      .first;
                  final incompletas = estadisticas
                      .where((i) =>
                          i.estadistica == 'FichasRegistradasIncompletas')
                      .first;
                  final completas = estadisticas
                      .where(
                          (i) => i.estadistica == 'FichasRegistradasCompletas')
                      .first;
                  final afiliadosReportados = estadisticas
                      .where((i) => i.estadistica == 'AfiliadosReportados')
                      .first;
                  final afiliadosRegistrados = estadisticas
                      .where((i) => i.estadistica == 'AfiliadosRegistrados')
                      .first;

                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => GraficasPage(
                        countCompletas: completas.cantidad!,
                        countInCompletas: incompletas.cantidad!,
                        countSincronizadas: reportadas.cantidad!,
                        countPendientes: registradas.cantidad!,
                        countAfiliadosRegistrados:
                            afiliadosRegistrados.cantidad!,
                        countAfiliadosReportados: afiliadosReportados.cantidad!,
                      ),
                    ),
                  );
                });
              },
            ),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.document_scanner),
                title: const Text('Consultar fichas sincronizadas'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'fichas-sincronizadas');
                }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phonelink_setup_outlined),
              title: const Text('Cambio de dispositivo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'cambio-dispositivo');
              },
            ),
            const Divider(),
            BlocListener<AuthBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is LoggedOut) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (route) => false);
                }
              },
              child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Cerrar sesión'),
                  onTap: () => authBloc.add(LogOut())),
            ),
          ],
        ),
      ),
    );
  }

  void comenzarSincronizacion(BuildContext context, User user, String type) {
    final syncBloc = BlocProvider.of<SyncBloc>(context);
    syncBloc.add(InitSync());
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (_) => SyncStatus(currentUser: user, type: type));
  }
}
