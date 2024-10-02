import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/core/constants.dart';
import 'package:ifasoris/ui/utils/custom_alerts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/sync/sync_bloc.dart';
import '../../utils/device_info.dart';
import 'sync_status.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
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
              leading: const Icon(Icons.phonelink_setup_outlined),
              title: const Text('Cambio de dispositivo'),
              onTap: () {
                final userName = user.userMetadata!['UserName'];
                CustomAlerts.showCustomDialog(context, 'Cambio de dispositivo',
                    'Se eliminará el dispositivo actual para el usuario $userName, deberá iniciar sesión con su nuevo dispositivo la próxima vez.',
                    () async {
                  final authBloc = BlocProvider.of<AuthBloc>(context);

                  await DeviceInfo.infoDispositivo().then((datosEquipo) async {
                    if (datosEquipo != null && datosEquipo.idEquipo != null) {
                      await authBloc
                          .cambioDispositivo(userName, datosEquipo.idEquipo!)
                          .then((value) {
                        if (value != '') {
                          authBloc.add(LogOut());
                        } else {
                          context.showErrorSnackBar(message: value.toString());
                        }
                      });
                    } else {
                      context.showErrorSnackBar(
                        message: 'No se pudo obtener el id del dispositivo',
                      );
                    }
                  });
                });
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
