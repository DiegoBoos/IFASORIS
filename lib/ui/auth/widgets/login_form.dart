import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/entities/usuario.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../cubits/internet/internet_cubit.dart';
import '../../home/pages/pdf_viewer_page.dart';
import '../../utils/device_info.dart';
import '../../utils/input_decoration.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final userNameCtrl = TextEditingController(text: 'sirispruebas');
  final passwordCtrl = TextEditingController(text: 'Siris*2024');
  /* final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();*/
  bool eyeToggle = true;
  bool _tyc = false;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);
    final internetCubit = BlocProvider.of<InternetCubit>(context);
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                controller: userNameCtrl,
                autocorrect: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Ingrese su usuario',
                    labelText: 'Nombre de usuario',
                    prefixIcon: Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: passwordCtrl,
                autocorrect: false,
                obscureText: eyeToggle,
                decoration: CustomInputDecoration.inputDecoration(
                  hintText: '******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: IconButton(
                      onPressed: () => setState(() => eyeToggle = !eyeToggle),
                      icon: eyeToggle
                          ? const Icon(
                              Icons.remove_red_eye,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.solidEyeSlash,
                              size: 18,
                            )),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              FormField<bool>(
                initialValue: _tyc,
                validator: (value) {
                  if (!value!) {
                    return 'Campo requerido';
                  }
                  return null;
                },
                builder: (formFieldState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        title: Container(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                                child: Text('Acepto términos y condiciones',
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.green)),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'tyc');
                                })),
                        value: formFieldState.value,
                        onChanged: (value) {
                          setState(() {
                            _tyc = value!;
                            formFieldState.didChange(value);
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      if (formFieldState.hasError)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            formFieldState.errorText!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30.0),
              MaterialButton(
                  minWidth: double.infinity,
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: authBloc.state is AuthLoading
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          await DeviceInfo.infoDispositivo()
                              .then((datosEquipo) {
                            if (datosEquipo != null &&
                                datosEquipo.idEquipo != null) {
                              final usuario = UsuarioEntity(
                                userName: userNameCtrl.text,
                                password: passwordCtrl.text,
                                deviceId: datosEquipo.idEquipo,
                              );

                              if (internetCubit.state is InternetConnected) {
                                authBloc.add(LogIn(usuario: usuario));
                              } else if (internetCubit.state
                                  is InternetDisconnected) {
                                authBloc.add(LogInDB(usuario: usuario));
                              }
                            } else {
                              authBloc.add(ErrorMsg(
                                  'No se pudo obtener el id del dispositivo'));
                            }
                          });
                        },
                  child: authBloc.state is AuthLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          'Iniciar sesión',
                          style: const TextStyle(color: Colors.white),
                        )),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                    child: const Text('Manual de usuario'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PDFViewerPage(
                                    filePath: 'assets/manual_usuario.pdf',
                                  )));
                    }),
              ),
            ],
          ),
        ));
  }
}
