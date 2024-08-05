import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/usuario.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/ficha/ficha_bloc.dart';
import '../../blocs/sync/sync_bloc.dart';
import '../../cubits/internet/internet_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../pages/graficas_page.dart';
import 'custom_appbar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final fichaBloc = BlocProvider.of<FichaBloc>(context);
    final usuario = authBloc.state.usuario ??
        const UsuarioEntity(userName: '', deviceId: '', password: ;

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
            SizedBox(
              height: 150.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Text(
                  usuario.userName ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.cloud_download),
              title: const Text('Sincronización (Descarga)'),
              onTap: () {
                Navigator.pop(context);
                comenzarSincronizacion(context, usuario, 'A');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.cloud_upload),
              title: const Text('Sincronización (Subida)'),
              onTap: () {
                Navigator.pop(context);
                comenzarSincronizacion(context, usuario, 'P');
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
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.pop(context);
                authBloc.add(LogOut());
              },
            ),
          ],
        ),
      ),
    );
  }

  void comenzarSincronizacion(
      BuildContext context, UsuarioEntity usuario, String type) {
    final internetCubit = BlocProvider.of<InternetCubit>(context);
    final syncBloc = BlocProvider.of<SyncBloc>(context);
    if (internetCubit.state is InternetConnected) {
      syncBloc.add(InitSync());
      showModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          context: context,
          builder: (_) => SyncStatus(usuario: usuario, type: type));
    } else if (internetCubit.state is InternetDisconnected) {
      CustomSnackBar.showSnackBar(
          context,
          'No es posible sincronizar, revise su conexión a internet',
          Colors.red);
    }
  }
}
