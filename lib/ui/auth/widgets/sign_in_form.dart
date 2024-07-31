import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/entities/usuario.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../cubits/internet/internet_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/device_info.dart';
import '../../utils/input_decoration.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  /* final userNameCtrl = TextEditingController(text: 'sirispruebas');
  final passwordCtrl = TextEditingController(text: 'Siris*2024'); */
  final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool eyeToggle = true;

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
                    hintText: 'Ingrese el nombre de usuario',
                    labelText: 'Nombre de usuario',
                    prefixIcon: Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Requerido*';
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
                    return 'Requerido*';
                  }
                  return null;
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
                              CustomSnackBar.showSnackBar(
                                  context,
                                  'No se pudo obtener el id del dispositivo',
                                  Colors.red);
                            }
                          });
                        },
                  child: authBloc.state is AuthLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Ingresar',
                          style: TextStyle(color: Colors.white),
                        )),
            ],
          ),
        ));
  }
}
