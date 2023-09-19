import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/sync/sync_bloc.dart';

class SyncDialog extends StatefulWidget {
  const SyncDialog({super.key, required this.type});

  final String type;

  @override
  State<SyncDialog> createState() => _SyncDialogState();
}

class _SyncDialogState extends State<SyncDialog> {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final syncBloc = BlocProvider.of<SyncBloc>(context);
    final usuario = authBloc.state.usuario!;
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<SyncBloc, SyncState>(builder: (context, state) {
          if (state is SyncSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sincronización completada',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text('Aceptar',
                        style:
                            TextStyle(color: Color(0xff01579B), fontSize: 18),
                        textAlign: TextAlign.center),
                  ),
                )
              ],
            );
          } else {
            return Column(children: [
              Text(
                widget.type == 'A'
                    ? 'Sincronización accesorias'
                    : 'Sincronización producción',
                style: const TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Divider(),
              GestureDetector(
                onTap: () {
                  syncBloc.add(SyncStarted(usuario, widget.type));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    'Sincronizar',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text('Cancelar',
                      style: TextStyle(color: Color(0xff01579B), fontSize: 18),
                      textAlign: TextAlign.center),
                ),
              )
            ]);
          }
        }));
  }
}
