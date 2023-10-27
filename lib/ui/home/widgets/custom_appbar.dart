import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth/auth_exports.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../blocs/sync/sync_bloc.dart';
import '../../sync/sync_dialog.dart';
import '../../search/search_afiliados.dart';
import '../../utils/custom_circular_progress.dart';
import '../../utils/custom_snack_bar.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);

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
        title: const Text('Buscar afiliado',
            style: TextStyle(color: Colors.white)),
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
                      delegate: SearchAfiliados(afiliadoBloc: afiliadoBloc));
                }
              },
              icon: const Icon(Icons.search)),
        ],
      ),
    );
  }
}

class SyncStatus extends StatelessWidget {
  final UsuarioEntity usuario;
  final String type;

  const SyncStatus({super.key, required this.usuario, required this.type});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<SyncBloc, SyncState>(builder: (context, state) {
        if (state is SyncDownloading || state is SyncPercentageInProgress) {
          return SyncProgress(
            title:
                '${state.syncProgressModel.title} ${state.syncProgressModel.percent}%',
            usuario: usuario,
            type: type,
          );
        }
        if (state is SyncIncrementInProgress) {
          return SyncProgress(
            title:
                '${state.syncProgressModel.title} ${state.syncProgressModel.counter} / ${state.syncProgressModel.total}',
            usuario: usuario,
            type: type,
          );
        }
        return SyncDialog(type: type);
      }),
    );
  }
}

class SyncProgress extends StatelessWidget {
  final String title;
  final UsuarioEntity usuario;
  final String type;

  const SyncProgress(
      {super.key,
      required this.title,
      required this.usuario,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CustomCircularProgress(alignment: Alignment.center),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
