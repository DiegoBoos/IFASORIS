import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/ficha_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
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
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
    final fichaBloc = BlocProvider.of<FichaBloc>(context);
    final usuario = authBloc.state.usuario ??
        UsuarioEntity(userName: '', deviceId: '', password: '');

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
                  usuario.userName,
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
              onTap: () {
                List<FichaEntity> fichasCompletas = [];
                List<FichaEntity> fichasInCompletas = [];
                List<FichaEntity> fichasSincronizadas = [];
                List<FichaEntity> fichasPendientes = [];
                final afiliado = afiliadoPrefsBloc.state.afiliado;
                if (afiliado != null) {
                  final future1 = fichaBloc.loadFichas(afiliado.familiaId!);
                  final future2 =
                      fichaBloc.loadFichasDiligenciadas(afiliado.familiaId!);

                  Future.wait([future1, future2]).then((values) {
                    final fichas = values[0];
                    final fichasDiligenciadas = values[1];

                    for (var ficha in fichas) {
                      for (var fichaDiligenciada in fichasDiligenciadas) {
                        if (fichaDiligenciada.fichaId == ficha.fichaId) {
                          fichasCompletas.add(fichaDiligenciada);
                        } else {
                          fichasInCompletas.add(fichaDiligenciada);
                        }
                      }

                      if (ficha.numFicha != '') {
                        fichasSincronizadas.add(ficha);
                      } else {
                        fichasPendientes.add(ficha);
                      }
                    }

                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => GraficasPage(
                            countCompletas: fichasCompletas.length,
                            countInCompletas: fichasInCompletas.length,
                            countSincronizadas: fichasSincronizadas.length,
                            countPendientes: fichasPendientes.length),
                      ),
                    );
                  });
                } else {
                  CustomSnackBar.showSnackBar(
                      context, 'No hay afiliado seleccionado', Colors.red);
                }
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phonelink_setup_outlined),
              title: const Text('Cambio de dispositivo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'cambio-dispositivo');
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
