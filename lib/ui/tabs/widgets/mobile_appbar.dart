import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth/auth_exports.dart';
import '../../blocs/sync/sync_bloc.dart';
import '../../cubits/internet/internet_cubit.dart';
import 'custom_snack_bar.dart';
import 'sync_dialog.dart';

class MobileAppBar extends StatelessWidget {
  const MobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usuario = authBloc.state.usuario!;
    final internetCubit = BlocProvider.of<InternetCubit>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushReplacementNamed(context, 'sign-in');
        }
      },
      child: BlocBuilder<SyncBloc, SyncState>(
        builder: (context, state) {
          if (state is InitializingSync) {
            return AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Iniciando sincronización...',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            );
          }
          if (state is SyncDownloading) {
            return AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '${state.syncProgress.title} ${state.syncProgress.percent}%',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 13)),
                  const SizedBox(width: 10),
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            );
          }
          if (state is SyncInProgress) {
            return AppBar(
              centerTitle: true,
              title: Text(
                  '${state.syncProgress.title} ${state.syncProgress.percent}%',
                  style: const TextStyle(color: Colors.white, fontSize: 13)),
            );
          } else {
            return AppBar(
              title: Text(usuario.userName,
                  style: const TextStyle(color: Colors.white)),
              actions: [
                IconButton(
                    onPressed: () => authBloc.add(LogOut()),
                    icon: const Icon(Icons.logout)),
                IconButton(
                  icon: const Icon(Icons.cloud_upload),
                  onPressed: () {
                    if (internetCubit.state is InternetConnected) {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return const SyncDialog();
                          });
                    } else if (internetCubit.state is InternetDisconnected) {
                      CustomSnackBar.showSnackBar(
                          context,
                          'No es posible sincronizar, revise su conexión a internet',
                          Colors.red);
                    }
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
