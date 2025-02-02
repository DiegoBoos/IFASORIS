import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/entities/grupo_familiar.dart';

import '../../blocs/afiliados/afiliados_bloc.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/grupo_familiar/grupo_familiar_bloc.dart';
import '../../blocs/sync/sync_bloc.dart';

class SyncDialog extends StatefulWidget {
  const SyncDialog({super.key, required this.type});

  final String type;

  @override
  State<SyncDialog> createState() => _SyncDialogState();
}

class _SyncDialogState extends State<SyncDialog> {
  late AuthBloc authBloc;
  late SyncBloc syncBloc;
  late AfiliadoPrefsBloc afiliadoPrefsBloc;
  late AfiliadosBloc afiliadosBloc;
  late GrupoFamiliarBloc grupoFamiliarBloc;

  @override
  void initState() {
    super.initState();

    authBloc = context.read<AuthBloc>();
    syncBloc = context.read<SyncBloc>();
    afiliadoPrefsBloc = context.read<AfiliadoPrefsBloc>();
    afiliadosBloc = context.read<AfiliadosBloc>();
    grupoFamiliarBloc = context.read<GrupoFamiliarBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<SyncBloc, SyncState>(listener: (context, state) {
            if (state is SyncSuccess) {
              final afiliado = afiliadoPrefsBloc.state.afiliado!;
              grupoFamiliarBloc.add(CheckFichaAfiliado(afiliado));
            }
          }),
          BlocListener<GrupoFamiliarBloc, GrupoFamiliarEntity>(
              listener: (context, state) {
            if (state.formStatus is GrupoFamiliarError) {
              final errorMsg = (state.formStatus as GrupoFamiliarError).message;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(errorMsg)));
            }
          })
        ],
        child: BlocBuilder<SyncBloc, SyncState>(builder: (context, state) {
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
                            style: TextStyle(
                                color: Color(0xff01579B), fontSize: 18),
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
                            style: TextStyle(
                                color: Color(0xff01579B), fontSize: 18),
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
                          syncBloc.add(SyncStarted(
                              authBloc.state.usuario!, widget.type));
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
                              style: TextStyle(
                                  color: Color(0xff01579B), fontSize: 18),
                              textAlign: TextAlign.center),
                        ),
                      )
                    ]));
          }
        }));
  }
}
