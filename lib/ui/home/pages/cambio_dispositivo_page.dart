import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/core/constants.dart';
import 'package:ifasoris/ui/blocs/auth/auth_bloc.dart';

import '../../utils/custom_snack_bar.dart';
import '../../utils/device_info.dart';

class CambioDispositivoPage extends StatefulWidget {
  const CambioDispositivoPage({super.key});

  @override
  State<CambioDispositivoPage> createState() => _CambioDispositivoPageState();
}

class _CambioDispositivoPageState extends State<CambioDispositivoPage> {
  final _textController = TextEditingController();

  @override
  void initState() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usuario = authBloc.state.usuario;
    _textController.text = usuario?.userName ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambio de dispositivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              enabled: false,
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final userName = _textController.text;
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Cambio de dispositivo'),
                      content: Text(
                          'Se eliminará el dispositivo actual para el usuario $userName, deberá loguearse con su nuevo dispositivo la próxima vez, desea continuar?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final authBloc = BlocProvider.of<AuthBloc>(context);

                            await DeviceInfo.infoDispositivo()
                                .then((datosEquipo) async {
                              if (datosEquipo != null &&
                                  datosEquipo.idEquipo != null) {
                                await authBloc
                                    .cambioDispositivo(
                                        userName, datosEquipo.idEquipo!)
                                    .then((value) {
                                  if (value != '') {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    authBloc.add(LogOut());
                                  } else {
                                    context.showErrorSnackBar(
                                        message: value.toString());
                                  }
                                });
                              } else {
                                CustomSnackBar.showSnackBar(
                                    context,
                                    'No se pudo obtener el id del dispositivo',
                                    Colors.red);
                              }
                            });
                          },
                          child: const Text('Aceptar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Cambiar dispositivo'),
            ),
          ],
        ),
      ),
    );
  }
}
