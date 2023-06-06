import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth/auth_exports.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../cubits/internet/internet_cubit.dart';
import '../../sync/sync_dialog.dart';
import '../../search/search_afiliados.dart';
import '../../utils/custom_snack_bar.dart';

class MobileAppBar extends StatelessWidget {
  final List<SyncTable> _downloadSyncTables = [
    SyncTable(name: 'Afiliado', type: 'A'),
    SyncTable(name: 'Accesorias', type: 'A'),
  ];

  final List<SyncTable> _uploadSyncTables = [
    SyncTable(name: 'DimUbicacion', type: 'P'),
    SyncTable(name: 'DimVivienda', type: 'P'),
  ];

  MobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);
    final usuario = authBloc.state.usuario!;
    final internetCubit = BlocProvider.of<InternetCubit>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.pushReplacementNamed(context, 'sign-in');
            }
          },
        ),
        BlocListener<AfiliadoBloc, AfiliadosState>(
          listener: (context, state) {
            if (state is AfiliadosError) {
              CustomSnackBar.showSnackBar(context, state.message, Colors.red);
            }
          },
        ),
      ],
      child: AppBar(
        elevation: 0,
        title:
            Text(usuario.userName, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () async {
                bool isEmpty =
                    await ConnectionSQLiteService.isTableEmpty('Afiliado');
                if (isEmpty) {
                  afiliadoBloc
                      .add(const ErrorMessage('No existen datos del afiliado'));
                } else {
                  showSearch(
                      context: context,
                      delegate: SearchAfiliados(afiliadoBloc));
                }
              },
              icon: const Icon(Icons.search)),
          IconButton(
            icon: const Icon(Icons.cloud_download),
            onPressed: () {
              if (internetCubit.state is InternetConnected) {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return SyncDialog(syncTables: _downloadSyncTables);
                    });
              } else if (internetCubit.state is InternetDisconnected) {
                CustomSnackBar.showSnackBar(
                    context,
                    'No es posible sincronizar, revise su conexión a internet',
                    Colors.red);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.cloud_upload),
            onPressed: () {
              if (internetCubit.state is InternetConnected) {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return SyncDialog(syncTables: _uploadSyncTables);
                    });
              } else if (internetCubit.state is InternetDisconnected) {
                CustomSnackBar.showSnackBar(
                    context,
                    'No es posible sincronizar, revise su conexión a internet',
                    Colors.red);
              }
            },
          ),
          IconButton(
              onPressed: () => authBloc.add(LogOut()),
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
