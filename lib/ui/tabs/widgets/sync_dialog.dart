import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/sync/sync_bloc.dart';

class SyncTable {
  String name;
  bool isChecked;

  SyncTable({required this.name, this.isChecked = false});
}

class SyncDialog extends StatefulWidget {
  const SyncDialog({super.key});

  @override
  State<SyncDialog> createState() => _SyncDialogState();
}

class _SyncDialogState extends State<SyncDialog> {
  final List<SyncTable> _syncTables = [
    SyncTable(name: 'Afiliado'),
    SyncTable(name: 'Accesorias'),
  ];

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usuario = authBloc.state.usuario!;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Seleccione las tablas que desea sincronizar',
            style: TextStyle(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Column(
              children: _syncTables
                  .map<Widget>((syncTable) => CheckboxListTile(
                        title: Text(syncTable.name),
                        value: syncTable.isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            syncTable.isChecked = value ?? false;
                          });
                        },
                      ))
                  .toList()),
          const Divider(),
          GestureDetector(
            onTap: _syncTables
                    .where((element) => element.isChecked == true)
                    .isEmpty
                ? null
                : () {
                    final checkedTables = _syncTables
                        .where((element) => element.isChecked == true);

                    final names = checkedTables.map((e) => e.name).toList();

                    BlocProvider.of<SyncBloc>(context)
                        .add(SyncStarted(usuario, names));

                    Navigator.pop(context);
                  },
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Sincronizar',
                style: TextStyle(
                    color: _syncTables
                            .where((element) => element.isChecked == true)
                            .isEmpty
                        ? Colors.grey
                        : Colors.red,
                    fontSize: 18),
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
          ),
        ],
      ),
    );
  }
}
