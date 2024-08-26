import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/core/constants.dart';

import '../../../domain/entities/afiliado.dart';
import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/sync/sync_bloc.dart';
import '../helpers/eliminar_ficha.dart';

class SyncDialog extends StatefulWidget {
  const SyncDialog({super.key, required this.type});

  final String type;

  @override
  State<SyncDialog> createState() => _SyncDialogState();
}

class _SyncDialogState extends State<SyncDialog> {
  @override
  Widget build(BuildContext context) {
    final syncBloc = BlocProvider.of<SyncBloc>(context);
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
    return BlocConsumer<SyncBloc, SyncState>(listener: (context, state) {
      if (state is SyncSuccess) {
        final afiliado = afiliadoPrefsBloc.state.afiliado!;
        existeFicha(afiliado, context);
      }
    }, builder: (context, state) {
      if (state is SyncFailure) {
        return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: const TextStyle(
                    color: Colors.red,
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
            ));
      }
      if (state is SyncSuccess) {
        return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
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
            ));
      } else {
        return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      final user = supabase.auth.currentUser!;
                      syncBloc.add(SyncStarted(user, widget.type));
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
                          style:
                              TextStyle(color: Color(0xff01579B), fontSize: 18),
                          textAlign: TextAlign.center),
                    ),
                  )
                ]));
      }
    });
  }

  Future<void> existeFicha(
      AfiliadoEntity afiliado, BuildContext context) async {
    final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);
    await afiliadoBloc
        .afiliadoTieneFicha(afiliado.afiliadoId!)
        .then((afiliadoFicha) async {
      if (afiliadoFicha != null) {
        await eliminarFicha(context, afiliado);
      }
    });
  }
}
